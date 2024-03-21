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
    //@IBOutlet weak var googleSignIn: GIDSignInButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        googleActivityIndicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.LogIn(email: email, password: password) { success, errorMessage in
            if success {
                //Nagivate to home view controller
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    //self.performSegue(withIdentifier: "LoginToHome", sender: self)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else { return }
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                           return
                       }
                    appDelegate.window?.rootViewController = loginViewController
                    appDelegate.window?.makeKeyAndVisible()
                }
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                sender.setTitle("Sign In →", for: .normal)
                self.displayError(errorMessage)
            }
        }
        
    }
    
    @IBAction func googleSignInBtn(_ sender: GIDSignInButton) {
        googleActivityIndicator.isHidden = false
        googleActivityIndicator.startAnimating()
        viewModel.LogInWithGoogle(presentingViewController: self) { success, errorMessage in
            if success {
                // Navigate to home view controller upon successful signup
                DispatchQueue.main.async {
                    self.googleActivityIndicator.stopAnimating()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else { return }
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                           return
                       }
                    appDelegate.window?.rootViewController = loginViewController
                    appDelegate.window?.makeKeyAndVisible()
                }
            } else {
                self.googleActivityIndicator.stopAnimating()
                self.googleActivityIndicator.isHidden = true
                self.displayError(errorMessage)
            }
        }
    }
        
    @IBAction func signUpPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
        appDelegate.window?.rootViewController = loginViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func forgetBtnPressed(_ sender: UIButton) {
        guard let forgetViewController = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController else { return }
        present(forgetViewController, animated: true, completion: nil)
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//               return
//           }
//        appDelegate.window?.rootViewController = forgetViewController
//        appDelegate.window?.makeKeyAndVisible()
    }
    
    func displayError(_ errorMessage: String?) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
