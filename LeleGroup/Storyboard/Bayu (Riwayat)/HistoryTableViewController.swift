//
//  HistoryTableViewController.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    struct Expandable{
        var isExpanded: Bool
        let kolam: [String]
        let temp: [Int]
    }
    
    var banyakKolam = [
        Expandable(isExpanded: true, kolam:["Kolam 1", "Kolam 2", "Kolam 3", "Kolam 4"], temp: [25, 23, 20, 25]),
        Expandable(isExpanded: true, kolam:["Kolam 5", "Kolam 6", "Kolam 7", "Kolam 8"], temp: [25, 23, 20, 25])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    }
    var selectedSection : Int? = nil
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let sectionTitle = UILabel()
        sectionTitle.frame = CGRect(x: 16, y: 4, width: 100, height: 25)
        sectionTitle.text = "Hari ini"
        sectionTitle.textColor = .gray
      
        view.addSubview(sectionTitle)
        let sectionToggleBtn = UIButton(type: .system)
        sectionToggleBtn.frame = CGRect(x: 300, y: 4, width: 100, height: 25)
        sectionToggleBtn.setImage(#imageLiteral(resourceName: "Chevron-top"), for: .normal)
        sectionToggleBtn.tintColor = .gray
        sectionToggleBtn.setTitleColor(.gray, for: .normal)
        sectionToggleBtn.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        sectionToggleBtn.tag = section
        
        sectionToggleBtn.contentHorizontalAlignment = .right
        sectionToggleBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        
        view.addSubview(sectionToggleBtn)

        return view
    }

    @objc func handleExpandClose(button:UIButton){

        print("try to expand section")
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in banyakKolam[0].kolam.indices{
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = banyakKolam[section].isExpanded
        banyakKolam[section].isExpanded = !isExpanded
        
//        button.setImage(isExpanded ? ">":"v", for: .normal)
        button.setImage(isExpanded ? #imageLiteral(resourceName: "Chevron-bottom"):#imageLiteral(resourceName: "Chevron-top"), for: .normal)
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: .none)
        }
        else{
            tableView.insertRows(at: indexPaths, with: .none)
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return banyakKolam.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !banyakKolam[section].isExpanded{
            return 0
        }
        return banyakKolam[section].kolam.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        let kolams = banyakKolam[indexPath.section].kolam[indexPath.row]
        let temp = banyakKolam[indexPath.section].temp[indexPath.row]
        
        
        if temp <= 20  {
            cell.customCellView.backgroundColor = #colorLiteral(red: 1, green: 0.2393657863, blue: 0.3002719581, alpha: 1).withAlphaComponent(0.25)
            cell.warningIcon.tintColor = #colorLiteral(red: 1, green: 0.2393657863, blue: 0.3002719581, alpha: 1)
        }
        else if temp <= 23 && temp > 20{
            cell.customCellView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).withAlphaComponent(0.25)
            cell.warningIcon.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }
        cell.customCellView.layer.cornerRadius = 10
        
        cell.pondLabel.text = kolams
        cell.tempLabel.text = "\(temp) C"
        cell.timeLabel.text = "10:10"
        return cell
    }

}
