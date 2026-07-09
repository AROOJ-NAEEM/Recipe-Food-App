//
//  User.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/24/24.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let userName: String
    
    init(uid: String, email: String, userName: String) {
        self.uid = uid
        self.email = email
        self.userName = userName
    }
}
