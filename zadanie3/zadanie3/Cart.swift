//
//  Cart.swift
//  zadanie3
//
//  Created by Przemek Pawlik on 20/12/2023.
//

import Foundation

class CartItem: Identifiable, ObservableObject {
    var id = UUID()
    var product: Product
    @Published var quantity: Int
    
    init(product: Product, quantity: Int = 1) {
        self.product = product
        self.quantity = quantity
    }
}

class Cart: ObservableObject {
    @Published var items: [CartItem] = []
    
    func addProduct(_ product: Product) {
        if let existingItem = items.first(where: { $0.product == product }) {
            existingItem.quantity += 1
        } else {
            let newItem = CartItem(product: product)
            items.append(newItem)
        }
    }
    
    func removeProduct(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
}

