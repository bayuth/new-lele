//
//  AllAlertViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class AllAlertViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var alertCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertCollectionView.dataSource = self
        alertCollectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let alertCell = collectionView.dequeueReusableCell(withReuseIdentifier: "allAlertCollectionCell", for: indexPath) as! CustomAlertCollectionViewCell
        
        alertCell.poolTitle!.text = "Kolam 1"
        alertCell.temperatureDetail?.text = "23 C"
        
        
        return alertCell
    }
}
