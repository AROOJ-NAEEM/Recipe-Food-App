//
//  ForgetPasswordViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendEmailBtnPressed(_ sender: UIButton) {
        if let email = emailTextfield.text {
            Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
                if (error != nil) {
                    print(error?.localizedDescription ?? "Error sending email.")
                } else {
                    print("sent!")
                    
                    DispatchQueue.main.async {
                        self?.displaySuccess("Email sent!")
                    }
                }
            }
        }
    }
    func displaySuccess(_ errorMessage: String?) {
        let alert = UIAlertController(title: "Success", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
