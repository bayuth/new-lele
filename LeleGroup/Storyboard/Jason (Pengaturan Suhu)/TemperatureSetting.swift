//
//  TemperatureSetting.swift
//  LeleGroup
//
//  Created by Jason Hartanto on 08/04/21.
//

import Foundation
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpan.layer.cornerRadius = 10
        
        //setting tampilan kotak
        temperatureSettingView.layer.cornerRadius = 20
        temperatureSettingView.layer.borderWidth = 1
        temperatureSettingView.layer.borderColor = UIColor.yellow.cgColor
        
        temperatureSettingView2.layer.cornerRadius = 20
        temperatureSettingView2.layer.borderWidth = 1
        temperatureSettingView2.layer.borderColor = UIColor.yellow.cgColor
        
        temperatureSettingView3.layer.cornerRadius = 20
        temperatureSettingView3.layer.borderWidth = 1
        temperatureSettingView3.layer.borderColor = UIColor.red.cgColor
        
        temperatureSettingView4.layer.cornerRadius = 20
        temperatureSettingView4.layer.borderWidth = 1
        temperatureSettingView4.layer.borderColor = UIColor.red.cgColor
        
        stepper.value=22
        stepper2.value=28
        stepper3.value=20
        stepper4.value=30
        
        temperatureLabel.text = String(Int(stepper.value)) + "°C"
        temperatureLabel2.text = String(Int(stepper2.value)) + "°C"
        temperatureLabel3.text = String(Int(stepper3.value)) + "°C"
        temperatureLabel4.text = String(Int(stepper4.value)) + "°C"
        
        //setting stepper
        stepper.isContinuous=true
        stepper.autorepeat=true
        stepper.maximumValue = stepper2.value - 2
        stepper.minimumValue = stepper3.value+1
        
        stepper2.isContinuous=true
        stepper2.autorepeat=true
        stepper2.maximumValue = stepper4.value-1
        stepper2.minimumValue = stepper.value + 2
        
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
        stepper2.minimumValue = stepper.value + 2
        stepper3.maximumValue = stepper.value-1
    }
    
    @IBAction func stepperValue2(_ sender: UIStepper) {
        temperatureLabel2.text = Int(sender.value).description + "°C"
        stepper2.value = sender.value
        stepper.maximumValue = stepper2.value - 2
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
    }
    
}
