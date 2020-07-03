//
//  aboutusViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 1/31/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit




class aboutusViewController: UIViewController {
    
     var centers: [MOCDCenter] = []
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
        //setupView()
        getCenters()
        
    }
    
    func getCenters() {
        WebService.getCenters { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [[String:Any]] else {return}
                //guard let list = results["list"] as? [[String:Any]] else {return}
               
                for c in results {
                    let centerItem: MOCDCenter = MOCDCenter()
                    
                    centerItem.center_address = c["center_address"] as? String ?? ""
                    centerItem.center_name = c["center_name"] as? String ?? ""
                    centerItem.email = c["email"] as? String ?? ""
                    centerItem.id = c["id"] as? String ?? ""
                    centerItem.latitude = c["latitude"] as? String ?? ""
                    centerItem.longitude = c["longitude"] as? String ?? ""
                    centerItem.telephone = c["telephone"] as? String ?? ""
                    
                    
                    self.centers.append(centerItem)
                    
                }
                
                DispatchQueue.main.async {
                  
                    self.tableView.reloadData()
                }
            }
        }
    }
    func setupView() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "mocd_logo")
        
        let logoview = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let logoavatarImage = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        logoavatarImage.setImage(logoImageView.image, for: .normal)
        logoavatarImage.imageView?.contentMode = .scaleAspectFill
        //avatarImage.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile"))
        logoavatarImage.clipView(withRadius: logoavatarImage.frame.width/2, withBoarderWidth: 0, borderColor: UIColor.clear)
        
        
        
        logoview.addSubview(logoavatarImage)
        let leftButton = UIBarButtonItem(customView: logoview)
        self.navigationItem.leftBarButtonItems = [leftButton]
    }
    
}
extension aboutusViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return centers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cellIdentifier = ""
        
        /*
        if indexPath.section == 0 {
            cellIdentifier = "telCell"
        }else{
            cellIdentifier = "centerCell"
        }*/
        
        cellIdentifier = "centerCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        /*
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
            cell.textLabel?.text = "telCell"
        }else {
            cell.textLabel?.text = "About Nomow"
        }
        */
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == "telCell" {
            let imageView = cell.viewWithTag(1) as! UIImageView
            let label = cell.viewWithTag(2) as! UILabel
            
            
            switch indexPath.row {
            case 0:
                label.text = "04-2632188"
                imageView.image = UIImage(named: "phone-2")
            case 1:
                label.text = "4409 Dubai"
                imageView.image = UIImage(named: "postbox")
            case 2:
                label.text = "Baghdad Road, Al Quasis 1 Dubai"
                imageView.image = UIImage(named: "pin")
            case 3:
                label.text = "nomow@mocd.gov.ae"
                imageView.image = UIImage(named: "mail")
            default:
                label.text = "04-2632188"
            }
        }
        
        if cell.reuseIdentifier == "centerCell" {
            let view = cell.viewWithTag(2)
            
            
            view?.layer.cornerRadius = 10
            view?.layer.masksToBounds = true
            let stackView = cell.viewWithTag(1)
            
            let centername = stackView?.viewWithTag(11) as! UILabel
            let cenetrEmirate = stackView?.viewWithTag(22) as! UILabel
            let cenetrNumber = stackView?.viewWithTag(33) as! UILabel
            
            
            let centerItem = centers[indexPath.row ]
            centername.text = centerItem.center_name
            cenetrEmirate.text = centerItem.center_address
            cenetrNumber.text = centerItem.telephone
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*
        if section == 0 {
            return ""
        }*/
        return "Centers"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        }
        
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
