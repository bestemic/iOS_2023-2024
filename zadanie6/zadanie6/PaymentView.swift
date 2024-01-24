//
//  PaymentView.swift
//  zadanie6
//
//  Created by Przemek Pawlik on 23/01/2024.
//

import SwiftUI
import CoreData
import StripePaymentSheet


struct PaymentView: View {
    @ObservedObject var cart: CartItems
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var model = BackendModel()
    
    @State private var cardNumber = ""
    @State private var ccv = ""
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                InputView(text: $cardNumber, title: "Card number:", placeholder: "Enter card number")
                    .autocapitalization(.none)
                
                InputView(text: $ccv, title: "CCV:", placeholder: "Enter CCV")
                    .autocapitalization(.none)
            }
            .padding(.horizontal)
            .padding(.top, 100)
            
            Button(action: {
                makeStandardPayment(cardNumber: cardNumber, ccv: ccv)
                
            }, label: {
                HStack {
                    Text("PAY")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 30, height: 40)
            })
            .background(Color(.systemBlue))
            .cornerRadius(9.0)
            .padding(.top, 15)
            .alert(isPresented: $isShowingAlert ) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .onDisappear {
                isShowingAlert = false
                alertMessage = ""
            }
            
            if let paymentSheet = model.paymentSheet {
                PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: model.onCompletion
                ) {
                    Text("Stripe pay")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 40)
                        .background(Color(.systemBlue))
                        .cornerRadius(9.0)
                        .padding(.top, 40)
                }
            } else {
                Text("Loading Stripe...")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 40)
                    .background(Color(.systemBlue))
                    .cornerRadius(9.0)
                    .padding(.top, 40)
            }
            if let result = model.paymentResult {
                switch result {
                case .completed:
                    Text("Payment complete")
                        .onAppear {
                            cart.items.removeAll()
                        }
                case .failed(let error):
                    Text("Payment failed: \(error.localizedDescription)")
                case .canceled:
                    Text("Payment canceled.")
                }
            }
            
            Spacer()
        }.onAppear { model.preparePaymentSheet(orderData: cart.items, viewContext: viewContext) }
    }
    
    
    func makeStandardPayment(cardNumber: String, ccv: String) {
        guard !cardNumber.isEmpty, !ccv.isEmpty else {
            isShowingAlert = true
            alertMessage = "Wprowadź poprawne dane."
            return
        }
        
        let cardNumberCharacterSet = CharacterSet.decimalDigits
        guard cardNumber.rangeOfCharacter(from: cardNumberCharacterSet.inverted) == nil,
              ccv.rangeOfCharacter(from: cardNumberCharacterSet.inverted) == nil else {
            isShowingAlert = true
            alertMessage = "Wprowadź poprawne dane składające się z samych cyfr."
            return
        }
        
        guard let url = URL(string: "http://127.0.0.1:5000/orders") else {
            return
        }
        
        let stringDictionary = Dictionary(uniqueKeysWithValues: cart.items.map { (String($0.key), $0.value) })
        
        let orderData: [String: Any] = [
            "card_number": cardNumber,
            "ccv": ccv,
            "orders": stringDictionary
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: orderData) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                let orderEntity = NSEntityDescription.entity(forEntityName: "Order", in: viewContext)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    if let order_data = json as? Dictionary<String, AnyObject> {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let id = order_data["id"] as! Int64
                        let total_value = order_data["total_value"] as! Double
                        let order_status = order_data["order_status"] as! String
                        let products = order_data["products"] as! [Int64]
                        
                        let uniqueProductsSet: Set<Int64> = Set(products)
                        let uniqueProductsArray: [Int64] = Array(uniqueProductsSet)
                        
                        if let dateString = order_data["order_date"] as? String,
                           let order_date = dateFormatter.date(from: dateString) {
                            let order = NSManagedObject(entity: orderEntity!, insertInto: viewContext)
                            order.setValue(id, forKey: "id")
                            order.setValue(total_value, forKey: "total_value")
                            order.setValue(order_status, forKey: "order_status")
                            order.setValue(order_date, forKey: "order_date")
                            order.setValue(products, forKey: "ordered_items")
                            
                            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
                            fetchRequest.predicate = NSPredicate(format: "id IN %@", uniqueProductsArray)
                            
                            do {
                                let products_data = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
                                for product in products_data {
                                    order.mutableSetValue(forKey: "products").add(product)
                                }
                                try viewContext.save()
                                print("Added order: id:\(id)")
                            } catch {
                                print("Error fetching products")
                            }
                        }
                    }
                } catch {
                    return
                }
            }
        }.resume()
        
        cart.items.removeAll()
    }
}


class BackendModel: ObservableObject {
    let backendCheckoutUrl = URL(string: "http://127.0.0.1:5000/create-payment-intent")!
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    
    func preparePaymentSheet(orderData:[Int : Int], viewContext: NSManagedObjectContext) {
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        
        let stringDictionary = Dictionary(uniqueKeysWithValues: orderData.map { (String($0.key), $0.value) })
        
        let orderData: [String: Any] = [
            "orders": stringDictionary
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: orderData) else {
            return
        }
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, _, _) in
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any],
                      let customerId = json["customer"] as? String,
                      let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                      let paymentIntentClientSecret = json["paymentIntent"] as? String,
                      let publishableKey = json["publishableKey"] as? String,
                      let order = json["order"] as? Dictionary<String, AnyObject>
                        
                else {
                    return
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let id = order["id"] as! Int64
                let total_value = order["total_value"] as! Double
                let order_status = order["order_status"] as! String
                let products = order["products"] as! [Int64]
                
                let uniqueProductsSet: Set<Int64> = Set(products)
                let uniqueProductsArray: [Int64] = Array(uniqueProductsSet)
                
                if let dateString = order["order_date"] as? String,
                   let order_date = dateFormatter.date(from: dateString) {
                    let orderEntity = NSEntityDescription.entity(forEntityName: "Order", in: viewContext)
                    let newOrder = NSManagedObject(entity: orderEntity!, insertInto: viewContext)
                    newOrder.setValue(id, forKey: "id")
                    newOrder.setValue(total_value, forKey: "total_value")
                    newOrder.setValue(order_status, forKey: "order_status")
                    newOrder.setValue(order_date, forKey: "order_date")
                    newOrder.setValue(products, forKey: "ordered_items")
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
                    fetchRequest.predicate = NSPredicate(format: "id IN %@", uniqueProductsArray)
                    
                    do {
                        let products_data = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
                        for product in products_data {
                            newOrder.mutableSetValue(forKey: "products").add(product)
                        }
                        try viewContext.save()
                        print("Added order: id:\(id)")
                    } catch {
                        print("Error fetching products")
                    }
                }
                
                STPAPIClient.shared.publishableKey = publishableKey
                var configuration = PaymentSheet.Configuration()
                configuration.customer = .init(
                    id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
                configuration.returnURL = "payments-example://stripe-redirect"
                
                DispatchQueue.main.async {
                    self.paymentSheet = PaymentSheet(
                        paymentIntentClientSecret: paymentIntentClientSecret,
                        configuration: configuration)
                }
            })
        task.resume()
    }
    
    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
    }
}


#Preview {
    PaymentView(cart: CartItems())
}
