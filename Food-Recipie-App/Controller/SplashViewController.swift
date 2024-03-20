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
        // Loop through your Recipe.all array and store each recipe in Firestore
        // Do any additional setup after loading the view.
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
        let initialViewController = HomeViewModel.shared.navigateToInitialScreen()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }

    
}
