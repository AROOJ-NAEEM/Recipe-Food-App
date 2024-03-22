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
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userNameLabel = userName {
            userNameLabel.text = ""
        } else {
            print("userName outlet is nil")
        }
        if let indicator = activityIndicator {
            indicator.startAnimating()
        } else {
            print("activityIndicator outlet is nil")
        }

        // Do any additional setup after loading the view.
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
                print("Error getting username")
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
