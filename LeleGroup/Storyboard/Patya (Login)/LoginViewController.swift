//
//  LoginViewController.swift
//  LeleGroup
//
//  Created by Patya Pindo on 08/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func masukPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToMain", sender: self)
    }
    
}
