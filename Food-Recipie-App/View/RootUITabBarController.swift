//
//  RootUITabBarController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import UIKit

class RootUITabBarController: UITabBarController, UITabBarControllerDelegate {

    let transition = SlideInTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is ProfileViewController {
            let profileViewController = ProfileViewController()
            
            profileViewController.transitioningDelegate = self.transition as? UIViewControllerTransitioningDelegate
            profileViewController.modalPresentationStyle = .custom
            
            self.present(profileViewController, animated: true, completion: nil)
        }
    }

}
