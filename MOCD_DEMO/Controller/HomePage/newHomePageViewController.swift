//
//  newHomePageViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 1/21/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class newHomePageViewController: UIViewController  , reloadHomePage ,NVActivityIndicatorViewable{
    var mocd_user = MOCDUser.getMOCDUser()

    var nvactivity : NVActivityIndicatorView!
    @IBOutlet var superCollectionView: UICollectionView!
    var appsCollectionView: UICollectionView!
   
    
    var catgeories: [CategoryItem] = []
    var selectedCategoryItem: Service!
    
    
    func reloadHome() {
        self.superCollectionView.collectionViewLayout.invalidateLayout()
        self.superCollectionView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nvactivity = NVActivityIndicatorView(frame: self.view.frame)
        
    
        superCollectionView.isPrefetchingEnabled = false
        superCollectionView.delegate = self
        superCollectionView.dataSource = self
        
        getMOCDServices()
        
        
        
        
        var profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "home-settings")
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let avatarImage = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        avatarImage.setImage(profileImageView.image, for: .normal)
        avatarImage.imageView?.contentMode = .scaleAspectFill
        //avatarImage.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile"))
        avatarImage.clipView(withRadius: avatarImage.frame.width/2, withBoarderWidth: 0, borderColor: UIColor.clear)
        
        
        avatarImage.addTarget(self, action: #selector(profileAction(_:)), for: .touchUpInside)
        view.addSubview(avatarImage)
        let rightBarButton = UIBarButtonItem(customView: view)
        
        
        var logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "mocd_logo")
        
        let logoview = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let logoavatarImage = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        logoavatarImage.setImage(logoImageView.image, for: .normal)
        logoavatarImage.imageView?.contentMode = .scaleAspectFill
        //avatarImage.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile"))
        logoavatarImage.clipView(withRadius: logoavatarImage.frame.width/2, withBoarderWidth: 0, borderColor: UIColor.clear)
        
        
        //logoavatarImage.addTarget(self, action: #selector(profileAction(_:)), for: .touchUpInside)
        logoview.addSubview(logoavatarImage)
        let leftButton = UIBarButtonItem(customView: logoview)
        
        
        self.navigationItem.rightBarButtonItems = [rightBarButton]
        if mocd_user?.userToken != nil {
            
            self.navigationItem.leftBarButtonItems = [leftButton]
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupNavigationBar()
    }
    
    @objc func profileAction(_ sender: Any) {
        //self.logout()
        
        self.performSegue(withIdentifier: "toSetting", sender: self)
    }
    
    func setupNavigationBar() {
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        
        
        let image: UIImage = UIImage(named: "brandmark")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        //self.navigationItem.title = "jngjrnejkgnkjregnjnrejkgnkjre"
       
        self.navigationItem.titleView = imageView
    }
    func setupAppsCollectionView() {
        
       
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.backgroundColor = .white
        appsCollectionView.showsVerticalScrollIndicator = false
           
        appsCollectionView.register(UINib(nibName: "servicesCollectionView", bundle: nil), forCellWithReuseIdentifier: "servicesCell")
           
        
        appsCollectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: self.superCollectionView.frame.height)
           
        if let layout = appsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.scrollDirection = .horizontal  // .vertical
           }
        
        appsCollectionView.reloadData()
    }
    
    
    func getMOCDServices() {
        
        DispatchQueue.main.async {
            //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
            
            
            
               
/*
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.stopAnimating(nil)
            }*/
        }
              
        WebService.getServices { (json) in
            
            print(json)
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["code"] as? Int else {return}
                      
            guard let message = json["message"] as? String else {return}
                       
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                
                
                for r in result {
                    let c = CategoryItem()
                    c.id = r["id"] as? String ?? ""
                    c.category_name_ar = r["category_name_ar"] as? String ?? ""
                    c.category_name_en = r["category_name_en"] as? String ?? ""
                    
                    
                    if let services = r["services"]  as? [[String: Any]] {
                        
                        
                        for s in services {
                            let sr = Service()
                            sr.id = s["id"] as? String ?? ""
                            sr.service_name_ar = s["service_name_ar"] as? String ?? ""
                            sr.service_name_en = s["service_name_en"] as? String ?? ""
                            sr.category_id = s["category_id"] as? String ?? ""
                            sr.service_code = s["service_code"] as? String ?? ""
                           
                            c.servicesArray.append(sr)
                        }
                    }
                    
                    
                    self.catgeories.append(c)
                    
                }
                
                
                DispatchQueue.main.async {
                    self.superCollectionView.reloadData()
                    self.superCollectionView.layoutIfNeeded()
                }
                
            }else{
                Utils.showAlertWith(title: "Error", message: message, viewController: UIApplication.shared.topMostViewController()!)
                return
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toSetting" {
            let dest = segue.destination as! UINavigationController
            let settingvc = dest.viewControllers[0] as! SettingViewController
            settingvc.reloadDelegate = self
        }
        if segue.identifier == "toserviceCard" {
            
            var dest = segue.destination as! serviceCardViewController
            dest.cItem = self.selectedCategoryItem
        }
    }
    
    
}


extension newHomePageViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == superCollectionView {
            
            if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true".lowercased() {
                
                return 1
            }
            return 1 + catgeories.count
        }
        if collectionView == self.appsCollectionView {
            
            if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true".lowercased() {
                return 1
            }
            return 4
            
        }
        
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = "Cell"
        
        
        if collectionView == superCollectionView {
            if indexPath.item == 0 {
                cellIdentifier = "appsCell"
            }else {
                cellIdentifier = "serviceCollectionViewCell"
            }
            
            return superCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        }
        
        if collectionView == self.appsCollectionView  {
            
            cellIdentifier = "servicesCell"
            
            
            let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! servicesCollectionView
            
            if indexPath.item == 0 {
                cell.backgroundImageView.image = UIImage(named: "namow_bg")
                cell.alphaImageView.backgroundColor = AppConstants.F_PURPLE_COLOR
                cell.appTitle.text = "My family with me".localize
                //cell.appdescription.text = ""
                
                
                cell.appdescription.text = "Early intervention stage for kids".localize
                cell.circularProgress.isHidden = true
                cell.firstProgressLine.isHidden = true
                cell.firstLinerProgressLabel.isHidden = true
                cell.firstValueProgressLabel.isHidden = true
                
                
                
                cell.secondProgressLine.isHidden = true
                cell.secondLinerProgressLabel.isHidden = true
                cell.secondValueProgressLabel.isHidden = true
                
                cell.backSmallImageView.backgroundColor = .white
                cell.smallIconImageView.image = UIImage(named: "namow_icon")
                
            }else if indexPath.item == 1{
                cell.backgroundImageView.image = UIImage(named: "edkhar_bg")
                cell.alphaImageView.backgroundColor = AppConstants.FIRST_GREEN_COLOR
                cell.appTitle.text = "Edkhar".localize
                cell.appdescription.text = "To help make your life easy".localize
                
                
                cell.circularProgress.isHidden = true
                cell.firstProgressLine.isHidden = true
                cell.firstLinerProgressLabel.isHidden = true
                cell.firstValueProgressLabel.isHidden = true
                
                
                
                cell.secondProgressLine.isHidden = true
                cell.secondLinerProgressLabel.isHidden = true
                cell.secondValueProgressLabel.isHidden = true
                
                
                cell.smallIconImageView.image = UIImage(named: "edkhar_icon")
                cell.backSmallImageView.backgroundColor = .white
            }else if indexPath.item == 2{
                cell.backgroundImageView.image = UIImage(named: "medical_agenda_bg")
                cell.alphaImageView.backgroundColor = AppConstants.F_RED_COLOR
                cell.appTitle.text = "Medical Agenda".localize
                cell.appdescription.text = "Recording parameters such as daily biometric data,medical appointments and any symptoms".localize
                
                
                cell.circularProgress.isHidden = true
                cell.firstProgressLine.isHidden = true
                cell.firstLinerProgressLabel.isHidden = true
                cell.firstValueProgressLabel.isHidden = true
                
                
                
                cell.secondProgressLine.isHidden = true
                cell.secondLinerProgressLabel.isHidden = true
                cell.secondValueProgressLabel.isHidden = true
                cell.smallIconImageView.image = UIImage(named: "medical_agenda_icon")
                cell.backSmallImageView.backgroundColor = .white
            }
            else if indexPath.item == 3{
                cell.backgroundImageView.image = UIImage(named: "stories_bg")
                cell.alphaImageView.backgroundColor = AppConstants.YELLOW_COLOR
                cell.appTitle.text = "Stories".localize
                cell.appdescription.text = "Stories for your children".localize
                
                
                cell.circularProgress.isHidden = true
                cell.firstProgressLine.isHidden = true
                cell.firstLinerProgressLabel.isHidden = true
                cell.firstValueProgressLabel.isHidden = true
                
                
                
                cell.secondProgressLine.isHidden = true
                cell.secondLinerProgressLabel.isHidden = true
                cell.secondValueProgressLabel.isHidden = true
                cell.smallIconImageView.image = UIImage(named: "stories_icon")
                cell.backSmallImageView.backgroundColor = .white
            }
            //scell.backgroundColor = .red
            return cell
        }
        
        
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == superCollectionView {
            
            if indexPath.item == 0 {
                
                self.appsCollectionView = cell.viewWithTag(1) as? UICollectionView
                
                
                self.setupAppsCollectionView()
            }else if cell.reuseIdentifier == "serviceCollectionViewCell" {
                
                let cell = cell as! serviceCollectionViewCell
                cell.homePage = self
                cell.titleLabel.text = catgeories[indexPath.row - 1].category_name_en
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                cell.layer.borderColor = UIColor.lightGray.cgColor
                cell.layer.borderWidth = 1
                
                cell.category = catgeories[indexPath.row - 1]
                cell.tableView.reloadData()
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == appsCollectionView {
            
            if mocd_user?.userToken == nil {
                
                let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
                self.view.window!.rootViewController = rootViewController
                rootViewController.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true, completion: {() -> Void in
                    self.present(rootViewController, animated: true, completion: {() -> Void in
                    })
                })
            }else{
                
                if indexPath.row == 0 {
                    self.performSegue(withIdentifier: "toNemo", sender: self)
                }else if indexPath.row == 1 {
                    AppDelegate().appDelegateShared().openED()
                }else if indexPath.row == 2 {
                    AppDelegate().appDelegateShared().openMG()
                }else if indexPath.row == 3 {
                    self.performSegue(withIdentifier: "toStroies", sender: self)
                }
                
            }
            
        }else {
            //self.performSegue(withIdentifier: "toEServices", sender: self)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == superCollectionView {
            if indexPath.item == 0 {
                
               // return CGSize(width: self.superCollectionView.frame.width, height: self.superCollectionView.frame.height) // height is 300
                return CGSize(width: self.superCollectionView.frame.width, height: 300) // height is 300
            }else{
                
                var height = 0
                
                var heightOfTableView: CGFloat = 50.0
                
                
                /*
                if let cell = superCollectionView.cellForItem(at: indexPath)  as? serviceCollectionViewCell{
                    
                    
                    var heightOfTableView: CGFloat = 0.0
                    // Get visible cells and sum up their heights
                    let cells = cell.tableView.visibleCells
                    for cell in cells {
                        heightOfTableView += cell.frame.height
                    }
                
                    
                }
                
                
                */
                
                
                
                let sCount = CGFloat (self.catgeories[indexPath.row - 1].servicesArray.count)
                
                let width = self.superCollectionView.frame.width  - 20
                return CGSize(width: width , height: 55 + (sCount * heightOfTableView))
            }
        }else if collectionView == self.appsCollectionView  {
            
            var heightR = Double(self.appsCollectionView.frame.width)
            let collectionViewHeight =  200.0 //Double(self.appsCollectionView.frame.width - 30.0)
            switch indexPath.row {
            case 0:
                heightR = Double((UserDefaults.standard.value(forKey: AppConstants.isNemowEnabled) as? Bool ?? true) ?  collectionViewHeight : 0.0)
            case 1:
                heightR = Double((UserDefaults.standard.value(forKey: AppConstants.isEdkharEnabled) as? Bool ?? true) ? collectionViewHeight : 0.0)
                
            case 2:
                heightR = Double((UserDefaults.standard.value(forKey: AppConstants.isMGEnabled) as? Bool ?? true) ? collectionViewHeight : 0.0)
            case 3:
                heightR = Double((UserDefaults.standard.value(forKey: AppConstants.isStoriesEnabled) as? Bool ?? true) ? collectionViewHeight : 0.0)
            default:
                print("")
            }
             return CGSize(width: heightR , height: 300)//width 200 // collectionViewWidth
             
             
             
            
            
        }
        
        
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}


