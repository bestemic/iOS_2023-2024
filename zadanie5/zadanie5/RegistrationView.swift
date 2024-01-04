//
//  RegistrationView.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 04/01/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                InputView(text: $firstName, title: "First name:", placeholder: "Enter first name")
                
                InputView(text: $lastName, title: "Last name:", placeholder: "Enter last name")
                
                InputView(text: $username, title: "Username:", placeholder: "Enter username")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                InputView(text: $password, title: "Password:", placeholder: "Enter password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 100)
            
            Button(action: {
                authModel.register(firstName: firstName, lastName: lastName, username: username, password: password)
            }, label: {
                HStack {
                    Text("SIGN UP")
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
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Have account?")
                    Text("LOG IN")
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
