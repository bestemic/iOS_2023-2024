//
//  ContentView.swift
//  zadanie4
//
//  Created by Przemek Pawlik on 28/12/2023.
//

import SwiftUI
import CoreData

class CartItems: ObservableObject {
    @Published var items: [String: Int] = [:]
    
    func addToCart(key: String) {
        if let existingValue = items[key] {
            items[key] = existingValue + 1
        } else {
            items[key] = 1
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    @State var tabSelection = 0
    
    @ObservedObject var cart = CartItems()
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            NavigationView {
                List {
                    ForEach(categories) { category in
                        HStack{
                            NavigationLink(category.name!, destination: CategoryView(category: category, cart: cart))
                        }
                    }
                }
            }.tabItem {
                Image(systemName: "list.dash")
                Text("Categories")
            }.tag(0)
            
            CartView(cart: cart).tabItem {
                Image(systemName: "cart")
                Text("Cart")
            }.tag(1)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
