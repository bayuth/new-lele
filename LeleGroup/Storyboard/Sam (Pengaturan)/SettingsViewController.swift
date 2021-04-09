//
//  SettingsViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBAction func showTemperatureSetting(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTemperatureSetting", sender: self)
    }
    
    @IBOutlet weak var viewPeringatanSuhu: UIView!
    @IBOutlet weak var viewAkun: UIView!
    @IBOutlet weak var viewBantuan: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPeringatanSuhu.layer.cornerRadius = 10
        viewAkun.layer.cornerRadius = 10
        viewBantuan.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
