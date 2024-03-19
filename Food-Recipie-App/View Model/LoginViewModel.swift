//
//  LoginViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn

class LoginViewModel {
    func LogIn(email: String, password: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                completion(false, e.localizedDescription)
            } else {
                completion(true, nil)
            }
            
        }
    }
    
    func LogInWithGoogle(presentingViewController: UIViewController, completion: @escaping(Bool, String?) -> Void ) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            // Start the sign-in flow!
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
                guard error == nil else {
                    // Handle Google Sign-In error
                    print("Google Sign-In Error: \(error!.localizedDescription)")
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString
                else {
                    // Handle missing user or ID token
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                // Sign in with Firebase using the Google credential
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        // Handle Firebase Sign-In error
                        completion(false, "Firebase Sign-In Error: \(error.localizedDescription)")
                    } else {
                        completion(true, nil)
                    }
                }
            }
    }
    
}
