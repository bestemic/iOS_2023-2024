//
//  AuthModel.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 04/01/2024.
//

import Foundation

class AuthModel: ObservableObject {
    @Published var user: User?
    @Published var alertMessage: String = ""
    @Published var isShowingAlert: Bool = false
    
    private let baseURL = "http://127.0.0.1:5000"
    
    init() {
    }
    
    func signIn(username: String, password: String) {
        guard let url = URL(string: "\(baseURL)/login") else {
            return
        }
        
        let userData: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userData) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if (401...).contains(httpResponse.statusCode) {
                self.showAlert(message: "Bad credentionals")
                return
            }
            
            do {
                self.user = try JSONDecoder().decode(User.self, from: data)
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    func register(firstName: String, lastName: String, username: String, password: String) {
        guard let url = URL(string: "\(baseURL)/register") else {
            return
        }
        
        let userData: [String: Any] = [
            "username": username,
            "password": password,
            "first_name": firstName,
            "last_name": lastName,
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userData) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if (400...).contains(httpResponse.statusCode) {
                self.showAlert(message: "User with this username already exists")
                return
            }
            
            do {
                self.user = try JSONDecoder().decode(User.self, from: data)
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    func signOut() {
        self.user = nil
    }
    
    func showAlert(message: String) {
        alertMessage = message
        isShowingAlert = true
    }
}
