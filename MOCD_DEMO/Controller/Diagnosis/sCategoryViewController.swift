//
//  sCategoryViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 12/11/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class sCategoryViewController: UIViewController ,NVActivityIndicatorViewable{
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var storiesList :[story] = []
    var storycategoriesList :[storyCategory] = []
    var selectedCategory: storyCategory = storyCategory()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getStories()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func getStories() {
        //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        WebService.getStories { (json) in
            
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                     
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let r = data["result"] as? [String: Any] else {return}
                guard let result = r["stories"] as? [[String: Any]] else {return}
                guard let categories = r["categories"] as? [[String: Any]] else {return}
                self.storiesList = []
                for r in result {
                    let s: story = story()
                    
                    s.storyId = r["id"] as? String  ?? ""
                    s.cover = r["cover"] as? String  ?? ""
                    s.link = r["link"] as? String  ?? ""
                    s.categoryId = r["category_id"] as? String ?? ""
                    s.title_ar = r["title_ar"] as? String  ?? ""
                    s.title_en = r["title_en"] as? String  ?? ""
                    
                   
                    self.storiesList.append(s)
                }
                self.storycategoriesList = []
                for c in categories {
                    let cat: storyCategory = storyCategory()
                    cat.categoryID = c["id"] as! String
                    cat.category_title_ar = c["title_ar"] as! String
                    cat.category_title_en = c["title_en"] as! String
                    
                    
                    self.storycategoriesList.append(cat)
                }
                
                for c in self.storycategoriesList{
                    c.stories = self.storiesList.filter { (story) -> Bool in
                        story.categoryId == c.categoryID
                    }
                    /*
                    var s = self.storycategoriesList.filter { (cresult) -> Bool in
                        cresult.categoryID == c.categoryID
                    }.first
                    
                    if s != nil {
                        s = c
                    }*/
                }
                DispatchQueue.main.async {
                    //self.filteredNFLTeams = self.storiesList
                    self.tableView.reloadData()
                }
                
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStoriesCategory" {
            let dest = segue.destination as! sListViewController
            dest.storiesList = selectedCategory.stories
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension sCategoryViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storycategoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = AppConstants.isArabic() ?  storycategoriesList[indexPath.row].category_title_ar : storycategoriesList[indexPath.row].category_title_en
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = storycategoriesList[indexPath.row]
        
        self.performSegue(withIdentifier: "toStoriesCategory", sender: self)
    }
}
