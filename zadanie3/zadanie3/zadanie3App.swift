//
//  zadanie3App.swift
//  zadanie3
//
//  Created by Przemek Pawlik on 13/12/2023.
//

import SwiftUI

@main
struct zadanie3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
