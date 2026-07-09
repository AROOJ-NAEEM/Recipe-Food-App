//
//  SplashViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/21/24.
//

import Foundation
import FirebaseAuth

class SplashViewModel: SplashViewModelProtocol {
    static let shared = SplashViewModel()
    
    func isUserAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
