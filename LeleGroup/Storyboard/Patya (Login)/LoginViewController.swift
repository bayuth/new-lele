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
    
    var user = "xYz921"
    var password = "lele12345"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.text = user
        passwordField.text = password

        // Do any additional setup after loading the view.
    }

    @IBAction func masukPressed(_ sender: Any) {
        isLogin = true
        self.navigationController?.popViewController(animated: true)
    }
    
}
