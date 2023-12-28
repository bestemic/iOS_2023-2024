//
//  zadanie4App.swift
//  zadanie4
//
//  Created by Przemek Pawlik on 28/12/2023.
//

import SwiftUI
import CoreData

@main
struct zadanie4App: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        loadData()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension zadanie4App {
    func loadData() {
        let context = persistenceController.container.viewContext
        
        if !categoriesExist() {
            let sampleData: [[String: Any]] = [
                ["category": ["name": "Electronics", "info": "Electronics products"],
                 "products": [["name": "Smartphone", "price": 999.99], ["name": "Laptop", "price": 1499.99]]],
                
                ["category": ["name": "Cloths", "info": "Cloths products"],
                 "products": [["name": "T-Shirt", "price": 19.99], ["name": "Jeans", "price": 39.99]]],
                
                ["category": ["name": "Books", "info": "Books products"],
                 "products": [["name": "Science Fiction", "price": 29.99], ["name": "Mystery", "price": 24.99]]],
            ]
            
            for data in sampleData {
                if let categoryData = data["category"] as? [String: String],
                   let categoryName = categoryData["name"],
                   let categoryInfo = categoryData["info"] {
                    
                    let newCategory = Category(context: context)
                    newCategory.name = categoryName
                    newCategory.info = categoryInfo
                    
                    if let productsData = data["products"] as? [[String: Any]] {
                        for productData in productsData {
                            if let productName = productData["name"] as? String,
                               let productPrice = productData["price"] as? Double {
                                
                                let newProduct = Product(context: context)
                                newProduct.name = productName
                                newProduct.price = productPrice
                                newProduct.category = newCategory
                            }
                        }
                    }
                }
            }
            
            do {
                try context.save()
            } catch {
                print("Error adding sample categories: \(error.localizedDescription)")
            }
        }
    }
    
    func categoriesExist() -> Bool {
        let context = persistenceController.container.viewContext
        
        do {
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            let categories = try context.fetch(request)
            return !categories.isEmpty
        } catch {
            return false
        }
    }
}
