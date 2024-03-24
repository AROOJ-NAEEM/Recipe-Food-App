//
//  SignUpExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/24/24.
//

import Foundation
import UIKit

extension SignupViewController: AuthenticationDelegate {
    
    func signUpDidSucceed(user: User) {
            navigateToHomeScreen()
        }

    func signInDidSucceed(user: User) {
        navigateToHomeScreen()
    }

    func authenticationDidFail(withError error: Error) {
        displayError(error.localizedDescription)
    }
    
    func navigateToHomeScreen() {
        self.activityIndicator.stopAnimating()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
        appDelegate.window?.rootViewController = loginViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
