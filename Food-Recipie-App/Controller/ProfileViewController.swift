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


}
