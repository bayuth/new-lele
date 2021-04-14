//
//  ViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit
import CocoaMQTT
import UserNotifications

class TemperatureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //    var poolData: [Pool] = Pool.generateDummyPool()
    //    var alertData: [Pool] = Alert.generateDummyAlert()
    var alertData: [Pool] = [
        Pool(id: 1, name: "Kolam 1", alert:
                Alert(id: 0, temperature: 23.0, status: "normal", isActive: false, lastUpdate: Date())),
        Pool(id: 2, name: "Kolam 2", alert:
                Alert(id: 0, temperature: 23.0, status: "normal", isActive: false, lastUpdate: Date()))
    ]
    
    //    var alertData: [Pool] = [Pool]()
    var poolData: [Pool] =
        [
            Pool(id: 1, name: "Kolam 1", alert:
                    Alert(id: 0, temperature: 26.0, status: "normal", isActive: false, lastUpdate: Date())),
            Pool(id: 2, name: "Kolam 2", alert:
                    Alert(id: 0, temperature: 23.0, status: "normal", isActive: false, lastUpdate: Date()))
        ]
    
    var isDataEmpty = true
    var stringHelper = StringHelper()
    
    //initialized core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var degreeLimit:[BatasSuhu] = []
    var userInit:[Pengguna] = []
    
    func tesCoreData(){
        do{
            self.degreeLimit = try context.fetch(BatasSuhu.fetchRequest())
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AllAlertViewController {
            let vc = segue.destination as? AllAlertViewController
            vc?.alertData = alertData
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        if !isLogin {
            temperatureIsEmptyView.isHidden = false
            temperatureIsNotEmptyView.isHidden = true
        } else {
            temperatureIsEmptyView.isHidden = true
            temperatureIsNotEmptyView.isHidden = false
            showAllAlertOutlet.setTitle("Lihat semua   ", for: .normal)
            runDataSourceAndDelegate()
        }
        
        if alertData[0].alert.status == "warning"  || alertData[1].alert.status == "warning" || alertData[1].alert.status == "danger"  || alertData[1].alert.status == "danger" {
            alertIsEmptyView.isHidden = true
            alertIsNotEmptyView.isHidden = false
        } else {
            alertIsEmptyView.isHidden = false
            alertIsNotEmptyView.isHidden = true
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tesCoreData()
        //initialized core data
        let printSuhu = self.degreeLimit
        
        if printSuhu == []{
            //Create Batas Suhu Object
            let newBatasSuhu = BatasSuhu(context: self.context)
            do {
                try self.context.save()
                self.tesCoreData()
                print("Saved")
            }
            catch{
                print("Error initializing default data")
            }
        }
        
        //connect to Mqtt
        mqttSetting()
        print("isLogin", isLogin)
        if !isLogin {
            temperatureIsEmptyView.isHidden = false
            temperatureIsNotEmptyView.isHidden = true
        } else {
            temperatureIsEmptyView.isHidden = true
            temperatureIsNotEmptyView.isHidden = false
            showAllAlertOutlet.setTitle("Lihat semua   ", for: .normal)
            runDataSourceAndDelegate()
        }
        
        /*if !checkIsDataEmpty(poolData.count) {
            temperatureIsEmptyView.isHidden = true
            temperatureIsNotEmptyView.isHidden = false
            showAllAlertOutlet.setTitle("Lihat semua ", for: .normal)
            runDataSourceAndDelegate()
        } else {
            temperatureIsEmptyView.isHidden = false
            temperatureIsNotEmptyView.isHidden = true
        }*/
        
        //        DispatchQueue.main.async {
        //            self.showAllAlertOutlet.setTitle("Lihat semua (\(self.alertData.count))", for: .normal)
        //            // etc
        //        }
        
        //        if !checkIsDataEmpty(alertData.count) {
        //            alertIsEmptyView.isHidden = true
        //            alertIsNotEmptyView.isHidden = false
        //            runDataSourceAndDelegate()
        //        } else {
        //            alertIsEmptyView.isHidden = false
        //            alertIsNotEmptyView.isHidden = true
        //        }
    }
    
    //Mqtt
    var mqtt: CocoaMQTT?
    var isMqttConnected = false
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
            //            if alertData.count == 0 {
            //                alertIsEmptyView.isHidden = true
            //                alertIsNotEmptyView.isHidden = false
            //            } else {
            //                alertIsEmptyView.isHidden = false
            //                alertIsNotEmptyView.isHidden = true
            //            }
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
            
            //            if alertData.count == 0 {
            //                alertIsEmptyView.isHidden = true
            //                alertIsNotEmptyView.isHidden = false
            //            } else {
            //                alertIsEmptyView.isHidden = false
            //                alertIsNotEmptyView.isHidden = true
            //            }
            
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
    
    //    func temperatureStatusCheck(degree: Int64, poolData: Pool) -> (String, Bool){
    //        var pool = poolData
    //        var status = ""
    //        var isActive = true
    //
    //        if degree < 0 {
    //            status = "device error"
    //            isActive = false
    //        } else {
    //            if degree > degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKuningAtas {
    //                status = "normal"
    //            } else if degree < degreeLimit[0].suhuKuningBawah && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
    //                pool.alert.status = "warning"
    //            } else if degree < degreeLimit[0].suhuKuningBawah && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
    //                pool.alert.status = "danger"
    //            }
    //        }
    //
    //        return (status, isActive)
    //    }
    
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
            isMqttConnected = true
            print("MQTT is Connected")
        }
        else{
            isMqttConnected = false
            print("MQTT is not connected")
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        let kuningBawah = Double(degreeLimit[0].suhuKuningBawah)
        let kuningAtas = Double(degreeLimit[0].suhuKuningAtas)
        let kritisBawah = Double(degreeLimit[0].suhuKritisBawah)
        let kritisAtas = Double(degreeLimit[0].suhuKritisAtas)
        
        let msg = message.string!
        let tempPool = stringHelper.getFirstWord(start: 7, words: msg )
        let poolName = tempPool
        
        let tempDegree = stringHelper.getMiddleWord(start: 10, end: -8, words: msg)
        guard let temperature = Double(tempDegree) else {return}
        
        print("MqttDidReceiveMessage PoolName: \(poolName), Temperature: \(temperature)=============")
        
        let degree = temperature
        //Pool Data
        if poolName == "Kolam 1" {
            var pool = poolData[0]
            //let statusOrIsActive = temperatureStatusCheck(degree: degree, poolData: poolData[0])
            //            poolData[0].alert.status = statusOrIsActive.0
            //            poolData[0].alert.isActive = statusOrIsActive.1
            poolData[0].alert.temperature = temperature
            if degree < 0 {
                poolData[0].alert.status = "device error"
                poolData[0].alert.isActive = false
            } else {
                if (degree > degreeLimit[0].suhuKuningBawah) && (degree < degreeLimit[0].suhuKuningAtas)  {
                    poolData[0].alert.status = "normal"
                    poolData[0].alert.isActive = true
                    print("si normal")
                } else if (degree < degreeLimit[0].suhuKuningBawah) && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
                    poolData[0].alert.status = "warning"
                    poolData[0].alert.isActive = true
                    print("si kuning")
                } else if degree < degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree > degreeLimit[0].suhuKritisAtas {
                    poolData[0].alert.status = "danger"
                    poolData[0].alert.isActive = true
                }
            }
            
        } else if poolName == "Kolam 2"{
            var pool = poolData[1]
            //let statusOrIsActive = temperatureStatusCheck(degree: degree, poolData: poolData[1])
            poolData[1].alert.temperature = temperature
            //            poolData[1].alert.status = statusOrIsActive.0
            //            poolData[1].alert.isActive = statusOrIsActive.1
            
            if degree < 0 {
                poolData[1].alert.status = "device error"
                poolData[1].alert.isActive = false
            } else {
                if degree > degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKuningAtas {
                    poolData[1].alert.status = "normal"
                    poolData[1].alert.isActive = true
                    
                } else if degree < degreeLimit[0].suhuKuningBawah && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
                    poolData[1].alert.status = "warning"
                    poolData[1].alert.isActive = true
                } else if degree < degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree > degreeLimit[0].suhuKritisAtas{
                    poolData[1].alert.status = "danger"
                    poolData[1].alert.isActive = true
                }
            }
        }
        
        //Alert Data
        if alertData.count == 0 {
            print("alert data = 0", alertData.count)
            if (degree < degreeLimit[0].suhuKuningBawah) && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas {
                alertData.append(
                    Pool(id:  0, name: poolName, alert: Alert(id: 0, temperature: temperature, status: "warning", isActive: true, lastUpdate: Date())))
            } else if (degree < degreeLimit[0].suhuKuningBawah) && (degree < degreeLimit[0].suhuKritisBawah) ||  (degree > degreeLimit[0].suhuKuningAtas) && (degree > degreeLimit[0].suhuKritisAtas){
                alertData.append(
                    Pool(id:  0, name: poolName, alert: Alert(id: 0, temperature: temperature, status: "danger", isActive: true, lastUpdate: Date())))
            }
        } else {
            print("alert data more than 1",alertData.count)
            if poolName == "Kolam 1" {
                alertData[0].alert.temperature = temperature
                if (degree > degreeLimit[0].suhuKuningBawah) && (degree < degreeLimit[0].suhuKuningAtas)  {
                    alertData[0].alert.status = "normal"
                    alertData[0].alert.isActive = true
                    print("si normal")
                } else if (degree < degreeLimit[0].suhuKuningBawah) && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
                    alertData[0].alert.status = "warning"
                    alertData[0].alert.isActive = true
                    print("si kuning")
                } else if degree < degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree > degreeLimit[0].suhuKritisAtas {
                    alertData[0].alert.status = "danger"
                    alertData[0].alert.isActive = true
                }
            }
            else if poolName == "Kolam 2"{
                alertData[1].alert.temperature = temperature
                
                if degree > degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKuningAtas {
                    alertData[1].alert.status = "normal"
                    alertData[1].alert.isActive = true
                } else if degree < degreeLimit[0].suhuKuningBawah && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
                    alertData[1].alert.status = "warning"
                    alertData[1].alert.isActive = true
                } else if degree < degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree > degreeLimit[0].suhuKritisAtas{
                    alertData[1].alert.status = "danger"
                    alertData[1].alert.isActive = true
                }
            }
        }
            
            /*let i = alertData.count - 1
             alertData[i].name = poolName
             alertData[i].id = i
             alertData[i].alert.temperature = temperature
             alertData[i].alert.lastUpdate = Date()
             
             if alertData[i].name == "Kolam 1" {
             if (degree < degreeLimit[0].suhuKuningBawah) && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
             alertData[i].alert.status = "warning"
             alertData[i].alert.isActive = true
             } else if degree < degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree > degreeLimit[0].suhuKritisAtas {
             alertData[i].alert.status = "danger"
             alertData[i].alert.isActive = true
             }
             
             } else if alertData[i].name == "Kolam 2"{
             if degree < degreeLimit[0].suhuKuningBawah && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
             alertData[i].alert.status = "warning"
             alertData[i].alert.isActive = true
             } else if degree < degreeLimit[0].suhuKuningBawah && degree < degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree > degreeLimit[0].suhuKritisAtas{
             alertData[i].alert.status = "danger"
             alertData[i].alert.isActive = true
             }
             } else {
             if (degree < degreeLimit[0].suhuKuningBawah) && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas {
             alertData.append(
             Pool(id:  0, name: poolName, alert: Alert(id: 0, temperature: temperature, status: "warning", isActive: true, lastUpdate: Date())))
             } else if (degree < degreeLimit[0].suhuKuningBawah) && (degree < degreeLimit[0].suhuKritisBawah) ||  (degree > degreeLimit[0].suhuKuningAtas) && (degree > degreeLimit[0].suhuKritisAtas){
             alertData.append(
             Pool(id:  0, name: poolName, alert: Alert(id: 0, temperature: temperature, status: "danger", isActive: true, lastUpdate: Date())))
             }
             }
             if (degree < degreeLimit[0].suhuKuningBawah) && degree > degreeLimit[0].suhuKritisBawah ||  degree > degreeLimit[0].suhuKuningAtas && degree < degreeLimit[0].suhuKritisAtas{
             alertData.append(
             Pool(id:  i, name: poolName, alert: Alert(id: i, temperature: temperature, status: "warning", isActive: true, lastUpdate: Date())))
             } else if (degree < degreeLimit[0].suhuKuningBawah) && (degree < degreeLimit[0].suhuKritisBawah) ||  (degree > degreeLimit[0].suhuKuningAtas) && (degree > degreeLimit[0].suhuKritisAtas){
             alertData.append(
             Pool(id:  i, name: poolName, alert: Alert(id: i, temperature: temperature, status: "danger", isActive: true, lastUpdate: Date())))
             }
             }*/
            
            
            alertCollectionView.reloadData()
            poolCollectionView.reloadData()
            
            if temperature == kuningBawah{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
                    if success{
                        let message = "Peringatan penurunan suhu pada kolam anda"
                        self.tempNotification(notifBody:message)
                    }
                    else if error != nil {
                        print("ada error", error)
                        
                    }
                })
            }
            else if temperature == kuningAtas{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
                    if success{
                        let message = "Peringatan peningkatan suhu pada kolam anda"
                        self.tempNotification(notifBody:message)
                    }
                    else if error != nil {
                        print("ada error",error)
                        
                    }
                })
            }
            else if temperature <= kritisBawah{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
                    if success{
                        let message = "Peringatan penurunan suhu secara ekstrim pada kolam anda"
                        self.tempNotification(notifBody:message)
                        //                    print(self.alertData[0].alert.temperature, self.alertData[1].alert.temperature)
                    }
                    else if error != nil{
                        print("ada error",error)
                        
                    }
                })
            }
            else if temperature >= kritisAtas{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
                    if success{
                        let message = "Peringatan peningkatan suhu secara ekstrim pada kolam anda"
                        self.tempNotification(notifBody:message)
                    }
                    else if (error != nil) {
                        print("ada error",error)
                        
                    }
                })
            }
            //print("didReceiveMessage", message.string!, message.topic)
        }
        
        func tempNotification(notifBody: String){
            let content = UNMutableNotificationContent()
            content.title = "Peringatan !"
            content.sound = .defaultCritical
            content.body = notifBody
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                if error != nil{
                    print("something went wrong")
                }
            })
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

