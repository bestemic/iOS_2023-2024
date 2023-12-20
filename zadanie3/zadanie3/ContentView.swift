//
//  ContentView.swift
//  zadanie3
//
//  Created by Przemek Pawlik on 13/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    @ObservedObject var cart = Cart()
    @State var tabSelection = 0
    
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
