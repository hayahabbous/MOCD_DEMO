//
//  serviceCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 1/22/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import HappinessMeter


class serviceCollectionViewCell: UICollectionViewCell {
    
    
    var category: CategoryItem = CategoryItem()
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var titleLabel: UILabel!
    
    var homePage: newHomePageViewController!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        titleLabel.text = category.category_name_en
    }

    
    
}
extension serviceCollectionViewCell: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.servicesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sCell", for: indexPath)
        
        cell.textLabel?.text = AppConstants.isArabic() ?  category.servicesArray[indexPath.row].service_name_ar : category.servicesArray[indexPath.row].service_name_en
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let user = MOCDUser.getMOCDUser()
        if user?.userToken == nil {
            
            
            let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
            self.window!.rootViewController = rootViewController
            rootViewController.modalPresentationStyle = .fullScreen
            homePage.dismiss(animated: true, completion: {() -> Void in
                self.homePage.present(rootViewController, animated: true, completion: {() -> Void in
                })
            })
            return
        }
        switch indexPath.row {
            
            
        case 0:
            if category.id == "1" {
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                           
                homePage.performSegue(withIdentifier: "toNewCard", sender: self)
            }else if category.id == "2" {
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toSocialAid", sender: self)
            }else{
                goTo(indexPath: indexPath)
            }
           
            
         case 1:
            
             if category.id == "1" {
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toLostCard", sender: self)
             }else if category.id == "2"{
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toCertificate", sender: self)
             }else{
                goTo(indexPath: indexPath)
             }
            
            
            
            
            
        case 2:
            
            if category.id == "1" {
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                //homePage.performSegue(withIdentifier: "toRenewal", sender: self)
                
                let rootViewController = UIStoryboard(name: "newCard", bundle: Bundle.main).instantiateViewController(withIdentifier: "newCardIdentifer")
                self.homePage.present(rootViewController, animated: true) {
                    
                }
            }else if category.id == "2"{
                
                
                
                
                let item = category.servicesArray[indexPath.row]
                
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openHappinessMeter"), object: nil)
                //homePage.performSegue(withIdentifier: "toOTP", sender: self)
                
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toMarriage", sender: self)
 
 
            }else{
                goTo(indexPath: indexPath)
            }
            
        case 3:
            
            
            homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
            homePage.performSegue(withIdentifier: "toNewEdaad", sender: self)
            
            //homePage.performSegue(withIdentifier: "toEdaad", sender: self)
            //homePage.performSegue(withIdentifier: "toOTP", sender: self)
            
        case 4:
            homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
            //homePage.performSegue(withIdentifier: "toMassWedding", sender: self)
            homePage.performSegue(withIdentifier: "toOTP", sender: self)
            
            
 
            
            
            
        default:
            print("no selection")
            
        }
        
        
    }
    

    func goTo(indexPath: IndexPath){
        homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
        switch homePage.selectedCategoryItem.service_code {
        case "EH":
           
            homePage.performSegue(withIdentifier: "toElderlyReg", sender: self)
        case "REC":
            
            homePage.performSegue(withIdentifier: "toNursing", sender: self)
        case "EA":
           
            homePage.performSegue(withIdentifier: "toVisiting", sender: self)
        default:
            print("non service")
        }
    }
    
}
