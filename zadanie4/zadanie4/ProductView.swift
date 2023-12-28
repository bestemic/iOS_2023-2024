//
//  ProductView.swift
//  zadanie4
//
//  Created by Przemek Pawlik on 28/12/2023.
//

import SwiftUI
import CoreData

struct ProductView: View {
    var product: Product
    @ObservedObject var cart: CartItems
    
    var body: some View {
        VStack {
            Text("Product Name: \(product.name ?? "")")
                .padding()
            Text("Product Price: $\(product.price)")
                .padding()
            Text("Product Category: \(product.category?.name ?? "")")
                .padding()
            Button(action: {
                cart.addToCart(key: product.name!)
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
