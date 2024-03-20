//
//  ProfileViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeViewModel.fetchName { [weak self] userName in
            if let userName = userName {
                DispatchQueue.main.async {
                    self?.userName.text = userName
                }
            } else {
                print("user is not signed in or data not found")
            }
        }
    }

    @IBAction func logOutPressed(_ sender: UIButton) {
        print("pressed")
        handleSignOut()
    }
    func handleSignOut() {
        HomeViewModel.shared.signOut {
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
