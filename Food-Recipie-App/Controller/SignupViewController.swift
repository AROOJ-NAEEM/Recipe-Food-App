//
//  SignupViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/7/24.
//

import UIKit
import GoogleSignIn

class SignupViewController: UIViewController {

    @IBOutlet weak var googleActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var termAndConditionLabel: UIButton!
    let viewModel = SignupViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        googleActivityIndicator.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        sender.setTitle("", for: .normal)
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPassTextField.text,
              let userName = userName.text,
              let btnImage = termAndConditionLabel.currentImage
        else { return }
        viewModel.signUp(email: email, password: password, confirmPassword: confirmPassword, userName: userName, btnImage: btnImage) { success, errorMessage in
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
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                sender.setTitle("Sign Up →", for: .normal)
                self.displayError(errorMessage)
            }
        }
    }
    
    
    @IBAction func googleSignUpBtn(_ sender: GIDSignInButton) {
        googleActivityIndicator.isHidden = false
        googleActivityIndicator.startAnimating()
        viewModel.signInWithGoogle(presentingViewController: self) { success, errorMessage in
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
    
    @IBAction func signInPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
        appDelegate.window?.rootViewController = loginViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    @IBAction func termAndConditionPressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    func displayError(_ errorMessage: String?) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
