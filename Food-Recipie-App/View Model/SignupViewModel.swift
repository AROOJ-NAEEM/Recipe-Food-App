//
//  SignupViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class SignupViewModel {
    private let databaseManager = DatabaseManager.shared
    func signUp(email: String, password: String, confirmPassword: String, userName: String, btnImage: UIImage, completion: @escaping(Bool, String?) -> Void) {
        if btnImage == UIImage(systemName: "checkmark.square") {
            if password == confirmPassword {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let e = error {
                            completion(false, e.localizedDescription)
                        } else {
                        if !userName.isEmpty {
                            if let userUID = Auth.auth().currentUser?.uid {
                                self.databaseManager.createUser(withUID: userUID, userName: userName) { error in
                                    if let error = error {
                                        completion(false, "Error creating user document: \(error.localizedDescription)")
                                    } else {
                                        completion(true, nil)
                                    }
                                }
                            } else {
                                completion(false, "User UID is nil")
                            }
                        } else {
                            completion(false, "Invalid User Name!")
                        }
                    }
                }
            } else {
                completion(false, "Password does not matched.")
            }
        } else {
            completion(false, "Accept terms and conditions first!")
        }
    }
    
    func signInWithGoogle(presentingViewController: UIViewController, completion: @escaping(Bool, String?) -> Void ) {
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
                        completion(false, "Firebase Sign-In Error: \(error.localizedDescription)")
                    } else {
                        completion(true, nil)
                    }
                }
            }
    }
}
