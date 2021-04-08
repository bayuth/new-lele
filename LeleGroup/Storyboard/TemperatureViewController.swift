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
        
        if !checkIsDataEmpty(poolData.count) {
            temperatureIsEmptyView.isHidden = true
            temperatureIsNotEmptyView.isHidden = false
            runDataSourceAndDelegate()
        } else {
            temperatureIsEmptyView.isHidden = false
            temperatureIsNotEmptyView.isHidden = true
        }
        
        if !checkIsDataEmpty(alertData.count) {
            alertIsEmptyView.isHidden = true
            alertIsNotEmptyView.isHidden = false
            runDataSourceAndDelegate()
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
    func checkIsDataEmpty(_ data:Int) -> Bool {
        if data == 0 {
           return true
        } else {
        return false
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
    
    func runDataSourceAndDelegate () {
        poolCollectionView.dataSource = self
        poolCollectionView.delegate = self
        alertCollectionView.dataSource = self
        alertCollectionView.delegate = self
    }
}

