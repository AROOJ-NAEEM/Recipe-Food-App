//
//  ForgetPasswordViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    var viewModel = ForgetPasswordViewModel()
    @IBOutlet weak var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendEmailBtnPressed(_ sender: UIButton) {
        if let email = emailTextfield.text {
            viewModel.sendEmail(email: email) { success, error in
                DispatchQueue.main.async {
                    self.displaySuccess(success)   
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
