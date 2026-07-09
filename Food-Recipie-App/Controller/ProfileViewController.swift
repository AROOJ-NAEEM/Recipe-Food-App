//
//  ProfileViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToButton()
        setupUI()
        fetchUsername()
    }
    
    func setupUI() {
        if let userNameLabel = userName {
            userNameLabel.text = ""
        } else {
            print("userName is nil")
        }
        if let indicator = activityIndicator {
            indicator.startAnimating()
        } else {
            print("activityIndicator is nil")
        }
    }
    
    func addShadowToButton() {
        logoutBtn.layer.shadowColor = UIColor.black.cgColor
        logoutBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        logoutBtn.layer.shadowOpacity = 0.5
        logoutBtn.layer.shadowRadius = 4
        logoutBtn.layer.masksToBounds = false
    }
    
    func fetchUsername() {
        ProfileViewModel.shared.fetchName { [weak self] userName in
            if let userName = userName {
                DispatchQueue.main.async {
                    if let userNameLabel = self?.userName {
                        userNameLabel.text = userName
                    }
                    if let activityIndicator = self?.activityIndicator {
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if let userNameLabel = self?.userName {
                        userNameLabel.text = "User Name"
                    }
                    if let activityIndicator = self?.activityIndicator {
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                    }
                }
            }
        }
    }

    @IBAction func logOutPressed(_ sender: UIButton) {
        handleSignOut()
    }
    func handleSignOut() {
        ProfileViewModel.shared.signOut {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                    return
                }
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.window?.rootViewController = loginViewController
                    appDelegate.window?.makeKeyAndVisible()
                }
            }
        }
        
    }

    
}
