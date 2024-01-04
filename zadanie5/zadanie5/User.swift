//
//  User.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 04/01/2024.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let username: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: "\(firstName) \(lastName)") {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCKED_USER = User(firstName: "John", lastName: "Doe", username: "johndoe12")
}
