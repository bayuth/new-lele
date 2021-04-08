//
//  AllAlertViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class AllAlertViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var alertCollectionView: UICollectionView!
    
    var alertData = Alert.generateDummyAlert()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertCollectionView.dataSource = self
        alertCollectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("alert data", alertData.count)
        return alertData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let alertCell = collectionView.dequeueReusableCell(withReuseIdentifier: "allAlertCollectionCell", for: indexPath) as! CustomAlertCollectionViewCell
        alertCell.alerts = alertData[indexPath.row]
        
        
        return alertCell
    }
}
