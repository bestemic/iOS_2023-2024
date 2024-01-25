//
//  ContentView.swift
//  zadadnie7
//
//  Created by Przemek Pawlik on 20/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeekView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Week")
                }
            
            ShopView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shop")
                }
        }
    }
}

#Preview {
    ContentView()
}
