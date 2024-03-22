//
//  ProfileViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {
    static let shared = ProfileViewModel()
    private let dbManager = DatabaseManager.shared
    
    func signOut(completion: @escaping () -> Void) {
       do {
           try Auth.auth().signOut()
           completion()
       } catch let signOutError as NSError {
           print("Error signing out: %@", signOutError)
       }
   }
    
    func fetchName(completion: @escaping (String?) -> Void) {
        dbManager.fetchName { name in
            completion(name)
        }
    }
    
}
