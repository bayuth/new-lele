//
//  ViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class TemperatureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var poolData: [Pool] = Pool.generateDummyPool()
    var alertData: [Pool] = Alert.generateDummyAlert()
    var isDataEmpty = true
    
    //Main Section
    @IBOutlet weak var temperatureIsEmptyView: UIView!
    @IBOutlet weak var temperatureIsNotEmptyView: UIView!
    
    
    //isEmpty Variable
    @IBAction func connectingToOperator(_ sender: UIButton) {
        goToHereBySenderTag(sender.tag)
    }
    
    @IBAction func doneInstalationButton(_ sender: Any) {
        print("sudah installasi")
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    //isNotEmpty Variable
    @IBOutlet weak var alertCollectionView: UICollectionView!
    @IBOutlet weak var poolCollectionView: UICollectionView!
    @IBOutlet weak var alertIsNotEmptyView: UIView!
    @IBOutlet weak var alertIsEmptyView: UIView!
    
    @IBOutlet weak var showAllAlertOutlet: UIButton!
    
    @IBAction func showAllAlertButton(_ sender: UIButton) {
        print("show all alert")
        performSegue(withIdentifier: "goToAllAlert", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIsDataEmpty()
        if !isDataEmpty {
            temperatureIsEmptyView.isHidden = true
            temperatureIsNotEmptyView.isHidden = false
            poolAndAlertDataSourceAndDelegate()
        } else {
            temperatureIsEmptyView.isHidden = false
            temperatureIsNotEmptyView.isHidden = true
        }
       
    }
    //CollectionView Func
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.alertCollectionView {
            return alertData.count
        } else {
            return poolData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.poolCollectionView {
            let poolCell = collectionView.dequeueReusableCell(withReuseIdentifier: "allPoolCollectionCell", for: indexPath) as! CustomPoolCollectionViewCell
            poolCell.pool = poolData[indexPath.row]
            
            return poolCell
            
        } else {
            let alertCell = collectionView.dequeueReusableCell(withReuseIdentifier: "alertCollectionCell", for: indexPath) as! CustomAlertCollectionViewCell
            
            alertCell.alerts = alertData[indexPath.row]
            
            
            return alertCell
        }
        
    }
    
    //Made Function
    func checkIsDataEmpty() {
        if poolData.count == 0 {
            isDataEmpty = true
        } else {
            isDataEmpty = false
        }
    }
    
    func goToHereBySenderTag (_ senderTag: Int) {
        print("sendertag \(senderTag)")
        let phoneNumber = "+6285312341234"
        let emailAddress = "customerservice@lele.com"
        var url = URL(string: "tel:\(phoneNumber)")!
        switch senderTag {
        case 1:
            url = URL(string: "message: \(emailAddress)")!
        case 2:
            url = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(url) {
               print("whatsapp installed")
            } else {
                url = URL(string: "https://wa.me/\(phoneNumber)")!
               print("whatsapp not installed")
            }
        case 3:
            url = URL(string: "tel:\(phoneNumber)")!
        default:
            print("failed")
        }
        
        if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }
    
    func poolAndAlertDataSourceAndDelegate () {
        poolCollectionView.dataSource = self
        poolCollectionView.delegate = self
        alertCollectionView.dataSource = self
        alertCollectionView.delegate = self
    }
    
    func cellStyle(status: String,alert: String){
        var bgColor, borderColor, iconColor: UIColor
        if status == "inactive" {
            //dark grey
            bgColor = .init(red: 153, green: 153, blue: 153, alpha: 1)
            borderColor = .clear
            iconColor = .clear
            
        } else {
            if alert == "warning" {
            //yellow
            bgColor = .init(red: 257, green: 181, blue: 0, alpha: 0.08)
            borderColor = .init(red: 257, green: 181, blue: 0, alpha: 1)
            iconColor = .init(red: 257, green: 181, blue: 0, alpha: 1)
            
        } else if alert == "danger" {
            //red
            bgColor = .init(red: 224, green: 132, blue: 32, alpha: 0.08)
            borderColor = .init(red: 224, green: 132, blue: 32, alpha: 1)
            iconColor = .init(red: 224, green: 132, blue: 32, alpha: 1)
            
        } else {
            //grey
            bgColor = .init(red: 249, green: 249, blue: 249, alpha: 1)
            borderColor = .init(red: 178, green: 178, blue: 178, alpha: 1)
            iconColor = .clear
        }
        
    }
    }

  


}

