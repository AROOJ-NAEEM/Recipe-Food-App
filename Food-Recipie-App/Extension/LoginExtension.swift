//
//  LoginExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/24/24.
//

import Foundation
import UIKit

extension LoginViewController: LoginViewModelDelegate {
    func loginDidSucceed() {
           activityIndicator.stopAnimating()
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else { return }
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
           appDelegate.window?.rootViewController = loginViewController
           appDelegate.window?.makeKeyAndVisible()
       }
       
       func loginDidFail(withError error: Error) {
           activityIndicator.stopAnimating()
           activityIndicator.isHidden = true
           displayError(error.localizedDescription)
       }
}
