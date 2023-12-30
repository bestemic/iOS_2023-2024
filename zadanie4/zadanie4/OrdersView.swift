//
//  OrdersView.swift
//  zadanie4
//
//  Created by Przemek Pawlik on 30/12/2023.
//

import SwiftUI

struct OrdersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    var body: some View {
        
        NavigationView {
            List(orders, id: \.id) { order in
                OrderRow(order: order)
            }
//            .navigationTitle("Orders", displayMode: .inline)
            .navigationBarTitle("Orders", displayMode: .inline)

        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct OrderRow: View {
    @State private var isExpanded = false
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Order Date: \(formattedDate(order.order_date ?? Date()))")
                    .font(.headline)
                Spacer()
                
                switch order.order_status{
                case "PROCESSING":
                    Image(systemName: "gear")
                        .foregroundColor(.blue) // Dostosuj kolor do swoich preferencji
                case "SHIPPED":
                    Image(systemName: "shippingbox")
                        .foregroundColor(.green) // Dostosuj kolor do swoich preferencji
                case "SEND":
                    Image(systemName: "paperplane")
                        .foregroundColor(.purple) // Dostosuj kolor do swoich preferencji
                default:
                    Text("Unknown Status")
                }
                
            }
            Text("Total Value: \(order.total_value)")
            
            if isExpanded {
                if let products = order.products?.allObjects as? [Product] {
                    ForEach(products, id: \.id) { product in
                        HStack {
                            Text(product.name ?? "Unknown Name")
                            Spacer()
                            Text("\(product.price)")
                        }
                        .padding(5)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}
