//
//  SettingsViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var isLogin = true
    @IBAction func showTemperatureSetting(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTemperatureSetting", sender: self)
    }
    
    @IBAction func buttonAkun(_ sender: UIButton) {
        
        if isLogin{
        performSegue(withIdentifier: "goToProfile", sender: self)
        } else {
            performSegue(withIdentifier: "goToLogin", sender: self)
        }
        
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var viewPeringatanSuhu: UIView!
    @IBOutlet weak var viewAkun: UIView!
    @IBOutlet weak var viewBantuan: UIView!
    @IBOutlet weak var peringatanKuning: UILabel!
    @IBOutlet weak var peringatanKritis: UILabel!
    
    var suhu:[BatasSuhu] = []
    
    func tesCoreData(){
        do{
            self.suhu = try context.fetch(BatasSuhu.fetchRequest())

        }
        catch{}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tesCoreData()
        viewPeringatanSuhu.layer.cornerRadius = 10
        viewAkun.layer.cornerRadius = 10
        viewBantuan.layer.cornerRadius = 10
        
        peringatanKuning.text = String((self.suhu[0].suhuKuningBawah)) + "°C , " + String((self.suhu[0].suhuKuningAtas)) + "°C"
        
        peringatanKritis.text = String((self.suhu[0].suhuKritisBawah)) + "°C , " + String((self.suhu[0].suhuKritisAtas)) + "°C"
    }
        
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tesCoreData()
//
//        viewPeringatanSuhu.layer.cornerRadius = 10
//        viewAkun.layer.cornerRadius = 10
//        viewBantuan.layer.cornerRadius = 10
//
//        peringatanKuning.text = String((self.suhu[0].suhuKuningBawah)) + "°C , " + String((self.suhu[0].suhuKuningAtas)) + "°C"
//
//        peringatanKritis.text = String((self.suhu[0].suhuKritisBawah)) + "°C , " + String((self.suhu[0].suhuKritisAtas)) + "°C"
//
////        peringatanKuning.text = String((suhu[0].suhuKuningBawah)) + "°C , " + String((suhu[0].suhuKuningAtas)) + "°C"
////
////        peringatanKritis.text = String((suhu[0].suhuKritisBawah)) + "°C , " + String((suhu[0].suhuKritisAtas)) + "°C"
//
//
//        // Do any additional setup after loading the view.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
