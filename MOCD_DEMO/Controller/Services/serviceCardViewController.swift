//
//  serviceCardViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 1/22/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class serviceCardViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    var imageView4: UIImageView!
    var imageView5: UIImageView!
    
    
    var serviceLabel1: UILabel!
    var serviceLabel2: UILabel!
    var serviceLabel3: UILabel!
    var serviceLabel4: UILabel!
    var serviceLabel5: UILabel!
   
    
    
    var serviceCard: String = "ServiceInfo"
    
    var cItem: Service!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        
    
        tableView.layoutIfNeeded()
        tableView.reloadData()
        
        
        //self.navigationController?.navigationBar.barTintColor = AppConstants.BROWN_COLOR
        //self.navigationController?.navigationBar.backgroundColor = AppConstants.BROWN_COLOR
    }
    
    
}
extension serviceCardViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        
        switch indexPath.row {
        case 0:
            cellIdentifier = "titleCell"
            
        case 1:
            cellIdentifier = "feeCell"
        case 2:
            cellIdentifier = "tabsCell"
            
        case 3,4,5,6:
            if serviceCard == "ServiceInfo" {
                cellIdentifier = "descCell"
            }else{
                cellIdentifier = "stepCell"
            }
            
        
        default:
            cellIdentifier = "descCell"
        }
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if cell.reuseIdentifier == "titleCell" {
            let titleLabel = cell.viewWithTag(1) as! UILabel
            let servicCodeLabel = cell.viewWithTag(2) as! UILabel
            
            
            titleLabel.text = cItem.service_name_en
            servicCodeLabel.text = cItem.service_code
        }
        if cell.reuseIdentifier == "tabsCell" {
            let stackView = cell.viewWithTag(1) as! UIStackView
            imageView1 = stackView.viewWithTag(11) as? UIImageView
            imageView2 = stackView.viewWithTag(22) as? UIImageView
            imageView3 = stackView.viewWithTag(33) as? UIImageView
            imageView4 = stackView.viewWithTag(44) as? UIImageView
            imageView5 = stackView.viewWithTag(55) as? UIImageView
            
            
            
            let stackViewLabels = cell.viewWithTag(2) as! UIStackView
            serviceLabel1 = stackViewLabels.viewWithTag(11) as? UILabel
            serviceLabel2 = stackViewLabels.viewWithTag(22) as? UILabel
            serviceLabel3 = stackViewLabels.viewWithTag(33) as? UILabel
            serviceLabel4 = stackViewLabels.viewWithTag(44) as? UILabel
            serviceLabel5 = stackViewLabels.viewWithTag(55) as? UILabel
            
            
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapDetected1))
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapDetected2))
            
            
            imageView1.addGestureRecognizer(tap1)
            imageView2.addGestureRecognizer(tap2)
            
            
        }
        if cell.reuseIdentifier == "feeCell" {
            let stackView = cell.viewWithTag(1) as! UIStackView
            let view1 = stackView.viewWithTag(11)
            let view2 = stackView.viewWithTag(22)
            
            view1?.layer.cornerRadius = 20
            view1?.layer.masksToBounds = true
            
            
            view2?.layer.cornerRadius = 20
            view2?.layer.masksToBounds = true
            
            
            
            
            
        }else if cell.reuseIdentifier == "descCell" {
            
            let serviceDesc = cell.viewWithTag(1) as! UILabel
            let serviceText = cell.viewWithTag(2) as! UITextView
            
            switch indexPath.row {
            case 3:
                serviceText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            case 4:
                serviceText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
            case 5:
                serviceText.text = "Lorem ipsum dolor sit er elit lamet."
            case 6:
                serviceText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
            default:
                print("")
            }
            
        }else if cell.reuseIdentifier == "stepCell" {
            let stepLabel = cell.viewWithTag(1) as! UILabel
            let descLabel = cell.viewWithTag(2) as! UILabel
            
            
            switch indexPath.row {
            case 3:
                stepLabel.text = "1"
                descLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                
                
            case 4:
                stepLabel.text = "2"
                descLabel.text = "Lorem ipsum dolor "
            case 5:
                stepLabel.text = "3"
                descLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, "
            case 6:
                stepLabel.text = "4"
                descLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ."
            default:
                print("")
            }
            self.tableView.layoutIfNeeded()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 80
        case 2:
            return 100
        case 3:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    //Action
    @objc func tapDetected1() {
        print("Imageview Clicked")
        
        serviceCard = "ServiceInfo"
        self.tableView.reloadData()
        imageView1.image = UIImage(named: "file_colored")
        imageView2.image = UIImage(named: "process")
        imageView3.image = UIImage(named: "conditions")
        imageView4.image = UIImage(named: "help")
        imageView5.image = UIImage(named: "usage")
        
        
        
        serviceLabel1.textColor = AppConstants.BROWN_COLOR
        serviceLabel2.textColor = .darkGray
        serviceLabel3.textColor = .darkGray
        serviceLabel4.textColor = .darkGray
        serviceLabel5.textColor = .darkGray
        
        
        //self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
    }
    //Action
    @objc func tapDetected2() {
        print("Imageview Clicked")
        
        serviceCard = "Help"
        
        self.tableView.reloadData()
        imageView1.image = UIImage(named: "info_1")
        imageView2.image = UIImage(named: "process_colored")
        imageView3.image = UIImage(named: "conditions")
        imageView4.image = UIImage(named: "help")
        imageView5.image = UIImage(named: "usage")
        
        
        serviceLabel1.textColor = .darkGray
        serviceLabel2.textColor = AppConstants.BROWN_COLOR
        serviceLabel3.textColor = .darkGray
        serviceLabel4.textColor = .darkGray
        serviceLabel5.textColor = .darkGray
        
        
        self.tableView.reloadData()
    }
}
