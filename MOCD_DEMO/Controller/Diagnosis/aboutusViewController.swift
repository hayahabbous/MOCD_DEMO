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
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
        //setupView()
        
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cellIdentifier = ""
        if indexPath.section == 0 {
            cellIdentifier = "telCell"
        }else{
            cellIdentifier = "centerCell"
        }
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
            let view = cell.viewWithTag(1)
            view?.layer.cornerRadius = 10
            view?.layer.masksToBounds = true
            view?.layer.borderColor = UIColor.lightGray.cgColor
            view?.layer.borderWidth = 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        return "Centers"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }
        
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
