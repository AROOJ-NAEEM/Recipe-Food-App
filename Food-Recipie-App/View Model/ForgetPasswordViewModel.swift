//
//  ForgetPasswordViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation
import FirebaseAuth

class ForgetPasswordViewModel {
    func sendEmail(email: String, completion: @escaping (String?, Error?) ->Void) {
        DatabaseManager.shared.sendPasswordResetEmail(to: email) { result, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(result, nil)
            }
        }
    }
}
