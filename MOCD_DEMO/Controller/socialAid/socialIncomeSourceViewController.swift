//
//  socialIncomeSourceViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/2/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialIncomeSourceViewController: UIViewController , addIncomeDelegate {
    func addFamily(familyItem: FamilyMember) {
        
    }
    
    func addIncome(incomeItem: Incom) {
        incomeItemsArray.append(incomeItem)
        
        self.tableView.reloadData()
    }
    
    var socialAidItem: socialAid = socialAid()
    @IBOutlet var tableView: UITableView!
    var incomeItemsArray: [Incom] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
    }
    
    func saveIncomes() {
        let parametersArray =  NSMutableArray()
               
        
        for r in incomeItemsArray {
            let dic: NSMutableDictionary = NSMutableDictionary()
            
            dic.setValue("\(r.incomeId)", forKey: "IncomeSourceId")
            dic.setValue("\(r.incomAmount)", forKey: "IncomeAmount")
            dic.setValue("\(r.companyName)", forKey: "Company")
            dic.setValue("\(r.incomeSource)", forKey: "IncomeSourceTypeAr")
            dic.setValue("\(r.incomeSource)", forKey: "IncomeSourceTypeEn")
            
            parametersArray.add(dic)
            
            
        }
               
        socialAidItem.incomesObject = parametersArray
        
    }
    
    
    
    @IBAction func addAction(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toAddIncome", sender: self)
    }
    @objc func submitAction() {
        saveIncomes()
        self.performSegue(withIdentifier: "toFamily", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddIncome" {
            let dest = segue.destination as! addIncomeViewController
            dest.delegate = self
        }else if segue.identifier == "toFamily" {
            let dest = segue.destination as! familyMemberInformationViewController
            dest.socialAidItem = self.socialAidItem
        }
    }
}
extension socialIncomeSourceViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + incomeItemsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        if indexPath.row == 0 {
            cellIdentifier = "infoCell"
        }else if indexPath.row == incomeItemsArray.count + 1{
            cellIdentifier = "doneCell"
        }else{
            cellIdentifier = "incomeCell"
        }
        
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == "doneCell"{
            
            
            let doneButton = cell.viewWithTag(1) as! UIButton
            let previousButton = cell.viewWithTag(2) as! UIButton
            
            
            
            let gradient = CAGradientLayer()
            gradient.frame = doneButton.bounds
            gradient.colors = [UIColor.green]
            
            doneButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
            //self.loginButton.backgroundColor = .green
            doneButton.layer.cornerRadius = 20
            doneButton.layer.masksToBounds = true
            
            
            gradient.frame = previousButton.bounds
            gradient.colors = [UIColor.green]
            
            previousButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
            //self.loginButton.backgroundColor = .green
            previousButton.layer.cornerRadius = 20
            previousButton.layer.masksToBounds = true
            
            
            doneButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
            
            
        }
        
        if cell.reuseIdentifier == "incomeCell" {
            
            let sourceLabel = cell.viewWithTag(1) as! UILabel
            let amountLabel = cell.viewWithTag(2) as! UILabel
            let companyLabel = cell.viewWithTag(3) as! UILabel
            
            
            let item = incomeItemsArray[indexPath.row - 1]
            sourceLabel.text = item.incomeSource
            amountLabel.text = item.incomAmount
            companyLabel.text = item.companyName
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }else  if indexPath.row == incomeItemsArray.count + 1 {
            return 120
        }else{
            return 170
        }
        
        
    }
}
