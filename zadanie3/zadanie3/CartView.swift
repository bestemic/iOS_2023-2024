//
//  CartView.swift
//  zadanie3
//
//  Created by Przemek Pawlik on 20/12/2023.
//

import SwiftUI

struct CartView: View {
    var cart: Cart
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cart.items) { cartItem in
                    VStack {
                        Text("Product Name: \(cartItem.product.name ?? "")")
                            .padding()
                        Text("Quantity: \(cartItem.quantity)")
                            .padding()
                        Spacer()
                    }
                }
                .onDelete(perform: deleteCartItem)
            }
        }
    }
    
    private func deleteCartItem(at offsets: IndexSet) {
        for index in offsets {
            let cartItem = cart.items[index]
            cart.removeProduct(cartItem)
        }
    }
}

