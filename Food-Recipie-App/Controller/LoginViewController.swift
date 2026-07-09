//
//  LoginViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/7/24.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var googleActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.googleActivityIndicator.isHidden = true
        }
        viewModel.delegate = self
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.LogIn(email: email, password: password) { success, errorMessage in
            if success {
                //Nagivate to home view controller
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else { return }
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                           return
                       }
                    appDelegate.window?.rootViewController = loginViewController
                    appDelegate.window?.makeKeyAndVisible()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    sender.setTitle("Sign In →", for: .normal)
                    self.displayError(errorMessage)
                }
            }
        }
        
    }
    
    @IBAction func googleSignInBtn(_ sender: GIDSignInButton) {
        DispatchQueue.main.async {
            self.googleActivityIndicator.isHidden = false
            self.googleActivityIndicator.startAnimating()
        }
        viewModel.LogInWithGoogle(presentingViewController: self) { success, errorMessage in
            if success {
                // Navigate to home view controller
                DispatchQueue.main.async {
                    self.googleActivityIndicator.stopAnimating()
                    self.navigateToHomeScreen()                }
            } else {
                DispatchQueue.main.async {
                    self.googleActivityIndicator.stopAnimating()
                    self.googleActivityIndicator.isHidden = true
                    self.displayError(errorMessage)
                }
            }
        }
    }
    
    func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
        appDelegate.window?.rootViewController = loginViewController
        appDelegate.window?.makeKeyAndVisible()
    }
        
    @IBAction func signUpPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else { return }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                   return
               }
            appDelegate.window?.rootViewController = loginViewController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func forgetBtnPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            guard let forgetViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController else { return }
            self.present(forgetViewController, animated: true, completion: nil)
        }
    }
    
    func displayError(_ errorMessage: String?) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

