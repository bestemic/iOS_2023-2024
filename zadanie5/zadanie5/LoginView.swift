//
//  LoginView.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 04/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack {
                    InputView(text: $username, title: "Username:", placeholder: "Enter username")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Password:", placeholder: "Enter password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 100)
                
                Button(action: {
                    authModel.signIn(username: username, password: password)
                    
                }, label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 40)
                })
                .background(Color(.systemBlue))
                .cornerRadius(9.0)
                .padding(.top, 15)
                .alert(isPresented: $authModel.isShowingAlert ) {
                    Alert(title: Text("Error"), message: Text(authModel.alertMessage), dismissButton: .default(Text("OK")))
                }
                .onDisappear {
                    authModel.isShowingAlert = false
                    authModel.alertMessage = ""
                }
                Spacer()
                
                OAuthView()
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have account?")
                        Text("SIGN UP")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
