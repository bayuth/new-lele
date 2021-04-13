//
//  CustomPoolCollectionViewCell.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class CustomPoolCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poolTitle: UILabel!
    @IBOutlet weak var temperatureDetail: UILabel!
    @IBOutlet weak var temperatureBox: UIView!
    
    var pool: Pool? {
        didSet{
            poolTitle?.text = pool?.name
            temperatureDetail?.text = "\(pool?.alert.temperature.toString ?? "") °C"
            temperatureBox.layer.cornerRadius = 10
            
            if !(pool?.alert.isActive ?? true) {
                temperatureDetail.textColor = .white
                temperatureBox?.backgroundColor = #colorLiteral(red: 0.4940721393, green: 0.4941467047, blue: 0.4940558076, alpha: 1)
                temperatureDetail.text = "Tidak Aktif"
                
            } else {
                let alert = pool?.alert.status
                temperatureBox.layer.borderWidth = 1
                if alert == "warning" {
                //yellow
                    temperatureBox?.backgroundColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 0.08)
                    temperatureBox?.layer.borderColor = #colorLiteral(red: 1, green: 0.7014456987, blue: 0, alpha: 1)
                
            } else if alert == "danger" {
                //red
                temperatureBox?.backgroundColor = #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 0.08)
                temperatureBox?.layer.borderColor =  #colorLiteral(red: 0.8771819472, green: 0.1257886291, blue: 0.1278358102, alpha: 1)
                
            } else {
                //grey
                temperatureBox?.backgroundColor = #colorLiteral(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)
                temperatureBox?.layer.borderColor = #colorLiteral(red: 0.6979769468, green: 0.6980791688, blue: 0.6979545951, alpha: 1)
            }
                
            }
        }
    }
}
