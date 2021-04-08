//
//  CustomAlertCollectionViewCell.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class CustomAlertCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poolTitle: UILabel?
    @IBOutlet weak var temperatureDetail: UILabel?
    @IBOutlet weak var timeUpdated: UILabel?
    @IBOutlet weak var alertIcon: UIImageView?
    @IBOutlet weak var temperatureBox: UIView?
    
    var alerts: Pool? {
        didSet{
            poolTitle?.text = alerts?.name
            
            temperatureDetail?.text = "\(alerts?.alert.temperature.toString ?? "") °C"
            
            let alert = alerts?.alert.status
            temperatureBox?.layer.borderWidth = 1
                if alert == "warning" {
                //yellow
                temperatureBox?.backgroundColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 0.08)
                    temperatureBox?.layer.borderColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 1)
                    alertIcon?.tintColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 1)
                
                } else if alert == "danger" {
                //red
                    temperatureBox?.backgroundColor = #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 0.08)
                    temperatureBox?.layer.borderColor =  #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 1)
                
                    alertIcon?.tintColor = #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 1)
                
                } else {
                //grey
                temperatureBox?.backgroundColor = #colorLiteral(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)
                temperatureBox?.layer.borderColor = #colorLiteral(red: 0.6979769468, green: 0.6980791688, blue: 0.6979545951, alpha: 1)
            }
        }
    }
}
