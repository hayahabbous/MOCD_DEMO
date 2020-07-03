//
//  serviceCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 1/22/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit



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
        
        
        switch indexPath.row {
            
            
        case 0:
            if category.id == "1" {
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                           
                homePage.performSegue(withIdentifier: "toNewCard", sender: self)
            }else{
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toSocialAid", sender: self)
            }
           
            
         case 1:
            homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
            homePage.performSegue(withIdentifier: "toLostCard", sender: self)
            
        case 2:
            
            if category.id == "1" {
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toRenewal", sender: self)
            }else{
                homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
                homePage.performSegue(withIdentifier: "toMarriage", sender: self)
            }
            
        case 3:
            homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
            homePage.performSegue(withIdentifier: "toEdaad", sender: self)
            
            
        case 4:
            homePage.selectedCategoryItem = category.servicesArray[indexPath.row]
            homePage.performSegue(withIdentifier: "toMassWedding", sender: self)
            
            
            
 
            
            
            
        default:
            print("no selection")
            
        }
        
        
    }
    
}
