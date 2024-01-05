//
//  SwiftUIView.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 04/01/2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct OAuthView: View {
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    GoogleSignInButton(action: authModel.signInGoogle)
                        .accessibilityIdentifier("GoogleSignInButton")
                        .accessibility(hint: Text("Sign in with Google button."))
                        .padding()
                }
            }
            
            HStack {
                VStack {
                    Button(action: {
                        authModel.signInFb()
                    }, label: {
                        Text("Facebook login")
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.blue)
                            
                    })
                    .padding()
                }
            }
            Spacer()
        }
    }
}


//#Preview {
//    OAuthView()
//}
