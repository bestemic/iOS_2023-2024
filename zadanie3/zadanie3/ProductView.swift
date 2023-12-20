//
//  ProductView.swift
//  zadanie3
//
//  Created by Przemek Pawlik on 19/12/2023.
//

import SwiftUI
import CoreData

struct ProductView: View {
    var product: Product
    @ObservedObject var cart: Cart
    
    var body: some View {
        VStack {
            Text("Product Name: \(product.name ?? "")")
                .padding()
            Text("Product Price: $\(product.price)")
                .padding()
            Text("Product Category: \(product.category?.name ?? "")")
                .padding()
            Button(action: {
                cart.addProduct(product)
                print(cart)
            }) {
                Text("Add to Cart")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .navigationBarTitle("Product Details", displayMode: .inline)
    }
}
