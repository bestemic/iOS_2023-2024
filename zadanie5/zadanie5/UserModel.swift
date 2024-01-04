//
//  UserModel.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 30/12/2023.
//

import Foundation

struct UserRegistration: Codable {
    var username: String
    var password: String
    var firstName: String
    var lastName: String
}

struct UserResponse: Codable {
    var username: String
    var firstName: String
    var lastName: String
}
