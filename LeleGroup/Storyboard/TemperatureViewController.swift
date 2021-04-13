//
//  ViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit
import CocoaMQTT

class TemperatureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var poolData: [Pool] = Pool.generateDummyPool()
    var alertData: [Pool] = Alert.generateDummyAlert()
    var isDataEmpty = true
    
    //initialized core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var suhu:[BatasSuhu] = []
    
    func tesCoreData(){
        do{
            self.suhu = try context.fetch(BatasSuhu.fetchRequest())
        }
        catch{}
    }

    
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
        
        //initialized core data
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
        
        if !checkIsDataEmpty(poolData.count) {
            temperatureIsEmptyView.isHidden = true
            temperatureIsNotEmptyView.isHidden = false
            showAllAlertOutlet.setTitle("Lihat semua (\(alertData.count))", for: .normal)
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
            alertIsEmptyView.isHidden = false
            alertIsNotEmptyView.isHidden = true
        }
       
        mqttSetting()
        
       
    }
    
    //Mqtt
    var mqtt: CocoaMQTT?
    func mqttSetting() {
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "maqiatto.com", port: 1883)
        mqtt!.username = "samuelmaynard13@gmail.com"
        mqtt!.password = "samuel13"
        mqtt!.willMessage = CocoaMQTTMessage(topic: "/will", string: "dieout")
        mqtt!.keepAlive = 60
        mqtt!.delegate = self
        mqtt?.connect()
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
            
        } else if collectionView == self.alertCollectionView {
            let alertCell = collectionView.dequeueReusableCell(withReuseIdentifier: "alertCollectionCell", for: indexPath) as! CustomAlertCollectionViewCell
            alertCell.alerts = alertData[indexPath.row]
    
            return alertCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alertCollectionCell", for: indexPath) as! CustomAlertCollectionViewCell
            return cell
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

extension TemperatureViewController: CocoaMQTTDelegate {
    // Optional ssl CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        
        /// Validate the server certificate
        ///
        /// Some custom validation...
        ///
        /// if validatePassed {
        ///     completionHandler(true)
        /// } else {
        ///     completionHandler(false)
        /// }
        completionHandler(true)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
  

        if ack == .accept {
            mqtt.subscribe("samuelmaynard13@gmail.com/testing1", qos: CocoaMQTTQoS.qos1)
            
            print("berhasil yey")
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("didReceiveMessage", message.string!, message.topic)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("subscribed: \(success), failed: \(failed)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("topic: \(topics)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print()
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print()
    }

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("\(err?.localizedDescription)")
    }
}


