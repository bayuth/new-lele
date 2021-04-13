//
//  UserProfileViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 13/04/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var poolNumberLabel: UILabel!
    @IBOutlet weak var userBox: UIView!
    @IBOutlet weak var poolBox: UIView!
    @IBOutlet weak var signOutButton: roundedButton!
    
    @IBAction func signOutButton(_ sender: UIButton) {
        askLogout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()

        // Do any additional setup after loading the view.
    }
    
    func askLogout() {
        let alert = UIAlertController (title: "Keluar?", message: "Apakah anda ingin keluar ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Batalkan", style: .destructive, handler: {action in print("tapped Dismiss")}))
        alert.addAction(UIAlertAction(title: "Keluar", style: .default, handler: {action in alertSuccess()}))
        
        func alertSuccess(){
            
            let alert2 = UIAlertController (title: "Anda berhasil keluar", message: nil, preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Selesai", style: .default, handler: {action in print("Selesai")
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert2, animated: true, completion: nil)
        }
        present(alert, animated:true, completion: nil)
    }
    
    
    func style() {
        userBox.layer.borderColor = #colorLiteral(red: 0.6979769468, green: 0.6980791688, blue: 0.6979545951, alpha: 1)
        userBox.layer.borderWidth  = 1
        userBox.layer.cornerRadius = 5
        
        poolBox.layer.borderColor = #colorLiteral(red: 0.6979769468, green: 0.6980791688, blue: 0.6979545951, alpha: 1)
        poolBox.layer.borderWidth  = 1
        poolBox.layer.cornerRadius = 5
        
        signOutButton.layer.borderColor = #colorLiteral(red: 0.2222680748, green: 0.3657891154, blue: 0.239493221, alpha: 1)
        signOutButton.layer.borderWidth  = 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
