//
//  CartView.swift
//  zadanie6
//
//  Created by Przemek Pawlik on 28/12/2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cart: CartItems
    
    var body: some View {
        
        VStack {
            List {
                ForEach(cart.items.sorted(by: <), id: \.key) { key, value in
                    HStack {
                        Text(key)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Stepper(value: Binding(
                            get: { value },
                            set: { newValue in
                                if newValue == 0 {
                                    cart.items.removeValue(forKey: key)
                                }
                                else{
                                    cart.items[key] = newValue
                                }
                            }
                        )) {
                            Label(
                                title: { Text("\(value)") },
                                icon: { Image(systemName: "42.circle") }
                            ).labelStyle(.titleOnly)
                        }
                    }
                }
            }
        }
    }
}
