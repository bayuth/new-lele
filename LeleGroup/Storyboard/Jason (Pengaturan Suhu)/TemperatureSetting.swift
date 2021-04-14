//
//  TemperatureSetting.swift
//  LeleGroup
//
//  Created by Jason Hartanto on 08/04/21.
//

import Foundation
import UIKit
import CoreData

class TemperatureSetting : UIViewController {
    
    @IBOutlet weak var temperatureSettingView: UIView!
    @IBOutlet weak var temperatureSettingView2: UIView!
    @IBOutlet weak var temperatureSettingView3: UIView!
    @IBOutlet weak var temperatureSettingView4: UIView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel2: UILabel!
    @IBOutlet weak var temperatureLabel3: UILabel!
    @IBOutlet weak var temperatureLabel4: UILabel!

    @IBOutlet weak var simpan: UIButton!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepper2: UIStepper!
    @IBOutlet weak var stepper3: UIStepper!
    @IBOutlet weak var stepper4: UIStepper!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var suhu:[BatasSuhu] = []
    
    func tesCoreData(){
        do{
            self.suhu = try context.fetch(BatasSuhu.fetchRequest())
        }
        catch{}
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tesCoreData()
        
        simpan.layer.cornerRadius = 10
        
        //setting tampilan kotak
        temperatureSettingView.layer.cornerRadius = 20
        temperatureSettingView.layer.borderWidth = 1
        temperatureSettingView.layer.borderColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 1)
        
        temperatureSettingView2.layer.cornerRadius = 20
        temperatureSettingView2.layer.borderWidth = 1
        temperatureSettingView2.layer.borderColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 1)
        
        temperatureSettingView3.layer.cornerRadius = 20
        temperatureSettingView3.layer.borderWidth = 1
        temperatureSettingView3.layer.borderColor = #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 1)
        
        temperatureSettingView4.layer.cornerRadius = 20
        temperatureSettingView4.layer.borderWidth = 1
        temperatureSettingView4.layer.borderColor = #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 1)
        
        let printSuhu = self.suhu
        
        if printSuhu == []{
                        
            //Create Batas Suhu Object
            let newBatasSuhu = BatasSuhu(context: self.context)
            
        do {
            try self.context.save()
            print("Saved")
        }
            catch{
                print("Error initializing default data")
            }
        }
        
        self.tesCoreData()
        
        stepper.value = Double(suhu[0].suhuKuningBawah)
        stepper2.value = Double(suhu[0].suhuKuningAtas)
        stepper3.value = Double(suhu[0].suhuKritisBawah)
        stepper4.value = Double(suhu[0].suhuKritisAtas)
        
        temperatureLabel.text = String(Int(stepper.value)) + "°C"
        temperatureLabel2.text = String(Int(stepper2.value)) + "°C"
        temperatureLabel3.text = String(Int(stepper3.value)) + "°C"
        temperatureLabel4.text = String(Int(stepper4.value)) + "°C"
        
        //setting stepper
        stepper.isContinuous=true
        stepper.autorepeat=true
        stepper.maximumValue = stepper2.value - 1
        stepper.minimumValue = stepper3.value+1
        
        stepper2.isContinuous=true
        stepper2.autorepeat=true
        stepper2.maximumValue = stepper4.value-1
        stepper2.minimumValue = stepper.value + 1
        
        stepper3.isContinuous=true
        stepper3.autorepeat=true
        stepper3.maximumValue = stepper.value-1
        stepper3.minimumValue = 10
        
        stepper4.isContinuous=true
        stepper4.autorepeat=true
        stepper4.maximumValue = 30
        stepper4.minimumValue = stepper2.value + 1
        
        
    }
    @IBAction func stepperValue(_ sender: UIStepper) {
        temperatureLabel.text = Int(sender.value).description + "°C"
        stepper.value = sender.value
        stepper2.minimumValue = stepper.value + 1
        stepper3.maximumValue = stepper.value-1
    }
    
    @IBAction func stepperValue2(_ sender: UIStepper) {
        temperatureLabel2.text = Int(sender.value).description + "°C"
        stepper2.value = sender.value
        stepper.maximumValue = stepper2.value - 1
        stepper4.minimumValue = stepper2.value + 1
    }
    
    @IBAction func stepperValue3(_ sender: UIStepper) {
        temperatureLabel3.text = Int(sender.value).description + "°C"
        stepper3.value = sender.value
        stepper.minimumValue = stepper3.value+1
    }
    
    @IBAction func stepperValue4(_ sender: UIStepper) {
        temperatureLabel4.text = Int(sender.value).description + "°C"
        stepper4.value = sender.value
        stepper2.maximumValue = stepper4.value-1
    }
    
    @IBAction func simpanSuhu(_ sender: UIButton) {
        
        let alert = UIAlertController (title: "Simpan Suhu", message: "Apakah anda ingin menyimpan suhu?", preferredStyle: .alert)
        
        func alertSuccess(){
            
            suhu[0].suhuKuningBawah = stepper.value
            suhu[0].suhuKuningAtas = stepper2.value
            suhu[0].suhuKritisBawah = stepper3.value
            suhu[0].suhuKritisAtas = stepper4.value

            do{
                try self.context.save()
            } catch {
                
            }
            
            let alert2 = UIAlertController (title: "Suhu berhasil disimpan", message: nil, preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Selesai", style: .default, handler: {action in print("Selesai")
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert2, animated: true, completion: nil)
        }
        
        alert.addAction(UIAlertAction(title: "Batalkan", style: .cancel, handler: {action in print("tapped Dismiss")}))
        
        alert.addAction(UIAlertAction(title: "Simpan", style: .default, handler: {action in alertSuccess()}))
        
        present(alert, animated:true, completion: nil)
        
    }
    
}
