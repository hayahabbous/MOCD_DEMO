//
//  sListViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 8/21/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Kingfisher
import PDFKit



class sListViewController: UIViewController ,UISearchResultsUpdating {
    
    var selectedStory: story = story()
    var storiesList :[story] = []
    let unfilteredNFLTeams = ["Bengals", "Ravens", "Browns", "Steelers", "Bears", "Lions", "Packers", "Vikings",
                              "Texans", "Colts", "Jaguars", "Titans", "Falcons", "Panthers", "Saints", "Buccaneers",
                              "Bills", "Dolphins", "Patriots", "Jets", "Cowboys", "Giants", "Eagles", "Redskins",
                              "Broncos", "Chiefs", "Raiders", "Chargers", "Cardinals", "Rams", "49ers", "Seahawks"].sorted()
    var filteredNFLTeams: [story]?
    let searchController = UISearchController(searchResultsController: nil)
    let activityData = ActivityData()
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredNFLTeams = storiesList.filter { team in
                return team.title_en.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredNFLTeams = storiesList
        }
        tableView.reloadData()
    }
    
    
    var notificationCollectionView: UICollectionView!
    
    @IBOutlet var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Stories".localize
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.tableFooterView = UIView()
        
        
        filteredNFLTeams = storiesList
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        tableView.tableHeaderView = searchController.searchBar
        setupView()
        //getStories()
       
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
        //self.navigationItem.leftBarButtonItems = [leftButton]
    }
    
    func setupCollectionView() {
        
        
        
        
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func getStories() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        
        WebService.getStories { (json) in
            
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                     
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let r = data["result"] as? [String: Any] else {return}
                guard let result = r["stories"] as? [[String: Any]] else {return}
                
                self.storiesList = []
                for r in result {
                    let s: story = story()
                    
                    s.storyId = r["id"] as? String  ?? ""
                    s.cover = r["cover"] as? String  ?? ""
                    s.link = r["link"] as? String  ?? ""
                    
                    s.title_ar = r["title_ar"] as? String  ?? ""
                    s.title_en = r["title_en"] as? String  ?? ""
                    
                   
                    self.storiesList.append(s)
                }
                
                
                DispatchQueue.main.async {
                    self.filteredNFLTeams = self.storiesList
                    self.tableView.reloadData()
                }
                
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPDF" {
            let p = segue.destination as! pdfViewer
            p.s = selectedStory
        }
        
    }
}
extension sListViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.notificationCollectionView {
            return 1
            
        }
        
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = "Cell"
        
        
        
        
        if collectionView == self.notificationCollectionView  {
            
            cellIdentifier = "notiCell"
            
            
            let cell = notificationCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! childNotificationCollectionViewCell
            
            
            
            let gradient = CAGradientLayer()
            gradient.frame = cell.bounds
            gradient.colors = [UIColor.green]
            
            cell.applyGradient(colours: [AppConstants.YELLOW_1_COLOR, AppConstants.YELLOW_2_COLOR])
            cell.profileImageView.image = UIImage(named: "open-book")
            cell.profileImageView.backgroundColor = .clear
            cell.backImageView.backgroundColor = .clear
            
            cell.titleLabel.text = "Continue Reading"
            cell.detailsLabel.text = "please follow naya objectives in order to check her health status "
            
            
            //scell.backgroundColor = .red
            return cell
        }
        
        
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //self.performSegue(withIdentifier: "toAssessment", sender: self)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == self.notificationCollectionView  {
            
            return CGSize(width: collectionView.frame.width - 20  , height: 80)
            
        }
        
        
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    
}
extension sListViewController: UITableViewDelegate ,UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        guard let nflTeams = filteredNFLTeams else {
            return 0
        }
        return nflTeams.count
     
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = "sCell"
        
       
        
        var s = filteredNFLTeams?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let textLabel = cell.viewWithTag(2) as! UILabel
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        textLabel.text = s?.title_en
        
        
        let url = URL(string: "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(s?.cover ?? "" )")
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "cover_ph") ?? UIImage())
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == "notiCell" {
            notificationCollectionView = cell.viewWithTag(1) as! UICollectionView
            
            notificationCollectionView.delegate = self
            notificationCollectionView.dataSource = self
            
            notificationCollectionView.showsVerticalScrollIndicator = false
            
            notificationCollectionView.register(UINib(nibName: "childNotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "notiCell")
            
            
            
            if let layout = notificationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
            notificationCollectionView.isPagingEnabled = true
            notificationCollectionView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var s = filteredNFLTeams?[indexPath.row]
        self.selectedStory = s!
        self.performSegue(withIdentifier: "toPDF", sender: self)
        
     
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
}
