//
//  ContentView.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 30/12/2023.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var authModel: AuthModel

    var body: some View {
        Group {
            if authModel.user != nil {
                UserView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    AppView()
}
