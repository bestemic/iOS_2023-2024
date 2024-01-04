//
//  zadanie5App.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 30/12/2023.
//

import SwiftUI

@main
struct zadanie5App: App {
    @StateObject var authModel = AuthModel()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(authModel)
        }
    } 
}
