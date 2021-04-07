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
            
            if !(pool?.alert.isActive ?? false) {
                temperatureDetail.textColor = .white
                temperatureBox?.backgroundColor = .init(red: 153, green: 153, blue: 153, alpha: 1)
                
            } else {
                let alert = pool?.alert.status
                temperatureBox.layer.borderWidth = 1
                if alert == "warning" {
                //yellow
                temperatureBox?.backgroundColor = .init(red: 257, green: 181, blue: 0, alpha: 0.08)
                    temperatureBox?.layer.borderColor = .init(red: 257, green: 181, blue: 0, alpha: 1)
                //iconColor = .init(red: 257, green: 181, blue: 0, alpha: 1)
                
            } else if alert == "danger" {
                //red
                temperatureBox?.backgroundColor = .init(red: 224, green: 132, blue: 32, alpha: 0.08)
                temperatureBox?.layer.borderColor = .init(red: 224, green: 132, blue: 32, alpha: 1)
                
                //iconColor = .init(red: 224, green: 132, blue: 32, alpha: 1)
                
            } else {
                //grey
                temperatureBox?.backgroundColor = .init(red: 249, green: 249, blue: 249, alpha: 1)
                temperatureBox?.layer.borderColor = .init(red: 178, green: 178, blue: 178, alpha: 1)
                //iconColor = .clear
            }
                
            }
            
        }
    }
}
