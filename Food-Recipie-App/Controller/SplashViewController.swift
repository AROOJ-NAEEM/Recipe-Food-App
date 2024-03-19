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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Loop through your Recipe.all array and store each recipe in Firestore
        // Do any additional setup after loading the view.
        if let gradientConfigurationBounds = gradient?.bounds {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = gradientConfigurationBounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            background.layer.addSublayer(gradientLayer)
        } else {
            print("Gradient configuration is nil or its bounds are nil.")
        }
    }
    
    @IBAction func startBtnPress(_ sender: UIButton) {
        print("Button Prssed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
        appDelegate.window?.rootViewController = loginViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
}
