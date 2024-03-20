//
//  HomeViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import Foundation
import FirebaseAuth

class HomeViewModel {
    static let shared = HomeViewModel()
    private let dbManager = DatabaseManager.shared
    func fetchName(completion: @escaping (String?) -> Void) {
        dbManager.fetchName { name in
            completion(name)
        }
    }
    
    func loadRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        dbManager.loadRecipes { recipes, error in
            completion(recipes, error)
        }

    }
    
    func navigateToInitialScreen() -> UIViewController {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
            guard let homeViewController = homeViewController as? UITabBarController else {
                fatalError("Main view controller is not of type UITabBarController")
            }
            return homeViewController
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            guard let loginViewController = loginViewController as? LoginViewController else {
                fatalError("Login view controller is not of type LoginViewController")
            }
            return loginViewController
        }
    }
    
    func signOut(completion: @escaping () -> Void) {
       do {
           try Auth.auth().signOut()
           completion()
       } catch let signOutError as NSError {
           print("Error signing out: %@", signOutError)
       }
   }
    
    
}
