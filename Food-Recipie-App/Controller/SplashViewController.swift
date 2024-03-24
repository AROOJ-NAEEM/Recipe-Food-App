//
//  FirstViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/7/24.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var background: UIImageView!
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addGradient()
    }
    
    func addGradient() {
        gradientLayer = CAGradientLayer()
        if let gradientConfigurationBounds = gradient?.bounds {
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            
            gradientLayer.frame = gradientConfigurationBounds
            background.layer.addSublayer(gradientLayer)
          } else {
            print("gradient configuration or bound is nil")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let gradientConfigurationBounds = gradient?.bounds {
            gradientLayer.frame = gradientConfigurationBounds
        }
    }
    
    @IBAction func startBtnPress(_ sender: UIButton) {
        let isAuthenticated = SplashViewModel.shared.isUserAuthenticated()
        navigateToInitialScreen(isAuthenticated: isAuthenticated)
    }

    func navigateToInitialScreen(isAuthenticated: Bool) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController: UIViewController
            if isAuthenticated {
                initialViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
            } else {
                initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("appdelegate nil")
            }
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
}
