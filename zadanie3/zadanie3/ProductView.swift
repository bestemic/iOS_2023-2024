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
    
    var body: some View {
        VStack {
            Text("Product Name: \(product.name ?? "")")
                .padding()
            Text("Product Price: $\(product.price)")
                .padding()
            Text("Product Category: \(product.category?.name ?? "")")
                .padding()
            Spacer()
        }
        .navigationBarTitle("Product Details", displayMode: .inline)
    }
}
