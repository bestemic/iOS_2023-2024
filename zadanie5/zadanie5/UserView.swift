//
//  UserView.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 04/01/2024.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        if let user = authModel.user {
            List {
                Section("Profile") {
                    HStack {
                        Text(user.initials)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background((Color.gray))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(user.firstName) \(user.lastName)")
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.username)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 10)
                    }
                }
                
                Section("Account") {
                    Button {
                        authModel.signOut()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "arrow.left.circle")
                                .imageScale(.small)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.red)
                            
                            Text("Sign Out")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserView()
}
