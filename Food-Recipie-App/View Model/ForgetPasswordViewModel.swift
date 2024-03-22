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
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if (error != nil) {
                completion(nil, error)
            } else {
                completion("Email sent", nil)
            }
        }
    }
}
