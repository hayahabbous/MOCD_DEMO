//
//  familyMemberInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/2/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class familyMemberInformationViewController: UIViewController  , addIncomeDelegate{
    func addIncome(incomeItem: Incom) {
        
    }
    
    func addFamily(familyItem: FamilyMember) {
        familyItemsArray.append(familyItem)
        
        self.tableView.reloadData()
    }
    
    var socialAidItem: socialAid = socialAid()
    @IBOutlet var tableView: UITableView!
    var familyItemsArray: [FamilyMember] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
    }
    
    
    func saveMembers() {
        var parametersArray =  NSMutableArray()
               
        
        for r in familyItemsArray {
            let dic: NSMutableDictionary = NSMutableDictionary()
            
            dic.setValue("\(r.memberName)", forKey: "ApplicantNameAR")
            dic.setValue("\(r.memberNameEn)", forKey: "ApplicantNameEN")
            dic.setValue("\(r.dateOfBirth)", forKey: "DateOfBirth")
            dic.setValue("\(r.genderId)", forKey: "GenderId")
            dic.setValue("\(r.gender)", forKey: "GenderTitleAr")
            dic.setValue("\(r.gender)", forKey: "GenderTitleEn")
            dic.setValue("\(r.educationId)", forKey: "EducationId")
            dic.setValue("\(r.relationId)", forKey: "Relation_ID")
            dic.setValue("\(r.relation)", forKey: "RelationshipTitleAr")
            dic.setValue("\(r.relation)", forKey: "RelationshipTitleEn")
            dic.setValue("\(r.motherName)", forKey: "MotherNameAR")
            dic.setValue("\(r.motherName)", forKey: "MotherNameEN")
            dic.setValue("\(r.diseaseId)", forKey: "DiseaseId")
            dic.setValue("\(r.nationalId)", forKey: "NationalId")
            dic.setValue("\(r.mobile)", forKey: "MobileNo")
            dic.setValue("\(r.email)", forKey: "EmailAddress")
            
            
            parametersArray.add(dic)
            
            
        }
        socialAidItem.membersObject = parametersArray
               
        
    }
    
    @IBAction func addFamilyAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toAddFamily", sender: self)
    }
    @objc func submitAction() {
        saveMembers()
        self.performSegue(withIdentifier: "toAttachment", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddFamily" {
            let dest = segue.destination as! addFamilyViewController
            dest.delegate = self
        }else if segue.identifier == "toAttachment" {
            let dest = segue.destination as! socialAttachmentViewController
            dest.socialAidItem = self.socialAidItem
        }
    }
}
extension familyMemberInformationViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + familyItemsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        if indexPath.row == 0 {
            cellIdentifier = "infoCell"
        }else if indexPath.row == familyItemsArray.count + 1{
            cellIdentifier = "doneCell"
        }else{
            cellIdentifier = "familyCell"
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
        if cell.reuseIdentifier == "familyCell" {
            
            let memberNameLabel = cell.viewWithTag(1) as! UILabel
            let memberNameEnLabel = cell.viewWithTag(2) as! UILabel
            let dateOfBirthLabel = cell.viewWithTag(3) as! UILabel
            let genderLabel = cell.viewWithTag(4) as! UILabel
            let educationLabel = cell.viewWithTag(5) as! UILabel
            let relationshipLabel = cell.viewWithTag(6) as! UILabel
            //let motherNameLabel = cell.viewWithTag(7) as! UILabel
            //let nationalIdLabel = cell.viewWithTag(8) as! UILabel
            //let mobileLabel = cell.viewWithTag(9) as! UILabel
            //let emailLabel = cell.viewWithTag(10) as! UILabel
            
            let item = familyItemsArray[indexPath.row - 1]
            memberNameLabel.text = item.memberName
            memberNameEnLabel.text = item.memberNameEn
            dateOfBirthLabel.text = item.dateOfBirth
            genderLabel.text = item.gender
            educationLabel.text = item.education
            relationshipLabel.text = item.relation
            //motherNameLabel.text = item.motherName
            //nationalIdLabel.text = item.nationalId
            //mobileLabel.text = item.mobile
            //emailLabel.text = item.email
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }else  if indexPath.row == familyItemsArray.count + 1{
            return 120
        }else{
            return 320
        }
        
        
    }
}
