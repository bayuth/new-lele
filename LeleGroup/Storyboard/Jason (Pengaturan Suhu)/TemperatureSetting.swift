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

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepper2: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //setting stepper
        stepper.isContinuous=true
        stepper.autorepeat=true
        
        stepper.maximumValue = stepper2.value - 2
        stepper.minimumValue = 10
        
        stepper2.isContinuous=true
        stepper2.autorepeat=true
        
        stepper2.maximumValue = 30
        stepper2.minimumValue = stepper.value + 2
        
        
    }
    @IBAction func stepperValue(_ sender: UIStepper) {
        temperatureLabel.text = Int(sender.value).description + "°C"
        stepper.value = sender.value
        stepper2.minimumValue = stepper.value + 2
    }
    
    @IBAction func stepperValue2(_ sender: UIStepper) {
        temperatureLabel2.text = Int(sender.value).description + "°C"
        stepper2.value = sender.value
        stepper.maximumValue = stepper2.value - 2
    }
}
