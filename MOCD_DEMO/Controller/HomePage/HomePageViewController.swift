//
//  HomePageViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/14/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit

import NVActivityIndicatorView


protocol reloadHomePage {
    func reloadHome()
}
class HomePageViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource ,reloadHomePage ,NVActivityIndicatorViewable{
    func reloadHome() {
        self.servicesCollectionView.reloadData()
        self.servicesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    
    var mocd_user = MOCDUser.getMOCDUser()
    
    
    @IBOutlet var tableView: UITableView!
    var servicesCollectionView: UICollectionView!
    var e_servicesCollectionView: UICollectionView!
    var nemoCollectionView: UICollectionView!
    var wisdomCollectionViewCell: UICollectionView!
    var medicalCollectionViewCell: UICollectionView!
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
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
        
        
        
        if mocd_user?.userToken != nil {
            self.navigationItem.rightBarButtonItems = [rightBarButton]
            self.navigationItem.leftBarButtonItems = [leftButton]
        }
        //addCurvedNavigationBar(backgroundColor: .white, curveRadius: 17.0, shadowColor: .lightGray, shadowRadius: 4.0, heightOffset: 0.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if servicesCollectionView != nil {
            self.servicesCollectionView.collectionViewLayout.invalidateLayout()
        }
        
    }
    
    
    @objc func profileAction(_ sender: Any) {
        //self.logout()
        
        self.performSegue(withIdentifier: "toSetting", sender: self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        return 2 // 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cellIdentifier = "titleCell"
            case 1:
                cellIdentifier = "newsCollectionViewCell"
            case 2:
                cellIdentifier = "titleCell"
            case 3:
                cellIdentifier = "eservicesCollectionViewCell"
            case 4:
                cellIdentifier = "seperateCell"
            case 5:
                cellIdentifier = "nemoCollectionViewCell"
            case 6:
                cellIdentifier = "seperateCell"
            case 7:
                cellIdentifier = "wisdomCollectionViewCell"
            case 8:
                cellIdentifier = "seperateCell"
            case 9:
                cellIdentifier = "medicalCollectionViewCell"
            default:
                cellIdentifier = ""
            }
        }else{
            cellIdentifier = "serviceCell"
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if section == 1 {
         
            
            let view = UIView()
            
            
            
            
            view.backgroundColor = AppConstants.BROWN_COLOR

            
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
         
            
            let view = UIView()
            view.backgroundColor = UIColor.white

            
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            return view
        }
        
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 44
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Services Section"
        }
        
        return nil
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.reuseIdentifier == "serviceCell" {
            
            
        }
        if cell.reuseIdentifier == "seperateCell" {
           cell.backgroundColor = .white
        }
        if cell.reuseIdentifier == "titleCell" {
            
            let titleLabel = cell.viewWithTag(1) as! UILabel
            let allButton = cell.viewWithTag(2) as! UIButton
            allButton.setTitle("more", for: .normal)
            allButton.isHidden = true
            
            if indexPath.row == 0 {
                titleLabel.text = "Our Services"//"Make Our Country Better"
            }else if indexPath.row == 2 {
                titleLabel.text = "Our Services"//"Our Services"
            }
            
            //cell.backgroundColor = .white
        }
        
        if cell.reuseIdentifier == "newsCollectionViewCell" {
            
            
            servicesCollectionView = cell.viewWithTag(1) as! UICollectionView
            
            
            servicesCollectionView.delegate = self
            servicesCollectionView.dataSource = self
            servicesCollectionView.backgroundColor = .white
            servicesCollectionView.showsVerticalScrollIndicator = false
            
            servicesCollectionView.register(UINib(nibName: "servicesCollectionView", bundle: nil), forCellWithReuseIdentifier: "servicesCell")
            
         
            servicesCollectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
            
            if let layout = servicesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
         
            servicesCollectionView.reloadData()
        }
        if cell.reuseIdentifier == "eservicesCollectionViewCell" {
            
            
            e_servicesCollectionView = cell.viewWithTag(1) as! UICollectionView
            
            
            e_servicesCollectionView.delegate = self
            e_servicesCollectionView.dataSource = self
            e_servicesCollectionView.backgroundColor = .white
            e_servicesCollectionView.showsVerticalScrollIndicator = false
            
            e_servicesCollectionView.register(UINib(nibName: "e_servicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "servicesCell")
            
            
            
            if let layout = e_servicesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
         
            e_servicesCollectionView.reloadData()
        }
        if cell.reuseIdentifier == "nemoCollectionViewCell" {
            
            
            nemoCollectionView = (cell.viewWithTag(1) as! UICollectionView)
            
            
            nemoCollectionView.delegate = self
            nemoCollectionView.dataSource = self
            nemoCollectionView.backgroundColor = .white
            nemoCollectionView.showsVerticalScrollIndicator = false
            
            nemoCollectionView.register(UINib(nibName: "nemoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "nemoCell")
            
            
            
            if let layout = nemoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
            
            nemoCollectionView.reloadData()
        }
        if cell.reuseIdentifier == "medicalCollectionViewCell" {
            
            
            medicalCollectionViewCell = (cell.viewWithTag(1) as! UICollectionView)
            
            
            medicalCollectionViewCell.delegate = self
            medicalCollectionViewCell.dataSource = self
            medicalCollectionViewCell.backgroundColor = .white
            medicalCollectionViewCell.showsVerticalScrollIndicator = false
            
            medicalCollectionViewCell.register(UINib(nibName: "nemoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "nemoCell")
            
            
            
            if let layout = medicalCollectionViewCell.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
            
            medicalCollectionViewCell.reloadData()
        }
        if cell.reuseIdentifier == "wisdomCollectionViewCell" {
            
            
            wisdomCollectionViewCell = (cell.viewWithTag(1) as! UICollectionView)
            
            
            wisdomCollectionViewCell.delegate = self
            wisdomCollectionViewCell.dataSource = self
            wisdomCollectionViewCell.backgroundColor = .white
            wisdomCollectionViewCell.showsVerticalScrollIndicator = false
            
            wisdomCollectionViewCell.register(UINib(nibName: "wisdomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wisdomcell")
            
            
            
            if let layout = wisdomCollectionViewCell.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
            
            wisdomCollectionViewCell.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return 0
            case 1:
                return 300
            case 2:
                return 44
            case 3:
                return 170
            case 4:
                return 10
            case 5:
                return 140
            case 6:
                return 10
            case 7:
                return 170
            case 8:
                return 10
            case 9:
                return 140
            default:
                return 0
            }
        }else{
            return 44
        }
        
    }
    
    func logout() {
        
        
        
        let logOutAlertActionController = UIAlertController(title:"", message: NSLocalizedString("Are you sure you want to signout ?", comment:""), preferredStyle: .alert )
               
               
        let yesAlerActionOption = UIAlertAction(title:NSLocalizedString("Sure",comment:""), style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
                DispatchQueue.main.async {
                     let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
                    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
                }
            let username = self.mocd_user?.username ?? ""
                
                WebService.logout(username: username){ (json) in
                    
                    DispatchQueue.main.async {
                        self.stopAnimating(nil)
                    }
                    guard let code = json["code"] as? Int else {return}
                              
                    guard let message = json["message"] as? String else {return}
                               
                    
                    if code == 200 {
                   
                        UserDefaults.standard.set(nil, forKey: AppConstants.MOCDUserData)
                        DispatchQueue.main.async {
                            if let window = self.view.window{
                            
                                
                                let welcomeNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                                                   
                                
                                window.rootViewController = welcomeNavigationViewController
                                
                                window.makeKeyAndVisible()
                                
                                
                            }
                        }
                        
                        
                    }else{
                                
                        Utils.showAlertWith(title: "Error", message: message, viewController: UIApplication.shared.topMostViewController()!)
                                                               
                                                            
                        return
                    }
                    
                }
            
        })
        
        let noAlertActionOption = UIAlertAction(title:NSLocalizedString("No",comment:""), style: .default, handler: nil)
        
        logOutAlertActionController.addAction(yesAlerActionOption)
        logOutAlertActionController.addAction(noAlertActionOption)
        
        self.present(logOutAlertActionController, animated: true, completion: nil)
        
        
                           
        
        
        /*
        let logOutAlertActionController = UIAlertController(title:"", message: NSLocalizedString("Are you sure you want to signout ?", comment:""), preferredStyle: .alert )
        
        let yesAlerActionOption = UIAlertAction(title:NSLocalizedString("Sure",comment:""), style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
            
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            PFUser.logOutInBackground(
                block: {(error) in
                    DispatchQueue.main.async {
                        self.stopAnimating(nil)
                    }
                    
                    if let window = self.view.window{
                        let welcomeNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                        
                        window.rootViewController = welcomeNavigationViewController
                        window.makeKeyAndVisible()
                        
                    }
            }
            )
        })
        
        let noAlertActionOption = UIAlertAction(title:NSLocalizedString("No",comment:""), style: .default, handler: nil)
        
        logOutAlertActionController.addAction(yesAlerActionOption)
        logOutAlertActionController.addAction(noAlertActionOption)
        
        self.present(logOutAlertActionController, animated: true, completion: nil)*/
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSetting" {
            let dest = segue.destination as! UINavigationController
            let settingvc = dest.viewControllers[0] as! SettingViewController
            settingvc.reloadDelegate = self
        }
    }
    
    
}
extension HomePageViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.servicesCollectionView {
            return 4
            
        }
        /*
        if collectionView == self.e_servicesCollectionView {
            return 6
            
        }
        if collectionView == self.nemoCollectionView {
            return 1
            
        }
        if collectionView == self.medicalCollectionViewCell {
            return 1
            
        }
        if collectionView == self.wisdomCollectionViewCell {
            return 1
            
        }*/
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = "Cell"
        
        
        
        
        if collectionView == self.servicesCollectionView  {
            
            cellIdentifier = "servicesCell"
            
            
            let cell = servicesCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! servicesCollectionView
            
            if indexPath.item == 0 {
                cell.backgroundImageView.image = UIImage(named: "nemoApp")
                cell.alphaImageView.backgroundColor = AppConstants.F_PURPLE_COLOR
                cell.appTitle.text = "Nemo".localize
                //cell.appdescription.text = ""
                
                
                cell.appdescription.text = "Early intervention stage for kids".localize
                cell.circularProgress.isHidden = true
                cell.firstProgressLine.isHidden = true
                cell.firstLinerProgressLabel.isHidden = true
                cell.firstValueProgressLabel.isHidden = true
                
                
                
                cell.secondProgressLine.isHidden = true
                cell.secondLinerProgressLabel.isHidden = true
                cell.secondValueProgressLabel.isHidden = true
                
                cell.backSmallImageView.backgroundColor = AppConstants.E_COLOR
                cell.smallIconImageView.image = UIImage(named: "care")
                
            }else if indexPath.item == 1{
                cell.backgroundImageView.image = UIImage(named: "edkhar")
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
                
                
                cell.smallIconImageView.image = UIImage(named: "get_cash")
                cell.backSmallImageView.backgroundColor = AppConstants.FIRST_GREEN_COLOR
            }else if indexPath.item == 2{
                cell.backgroundImageView.image = UIImage(named: "medical")
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
                cell.smallIconImageView.image = UIImage(named: "medical_doctor")
                cell.backSmallImageView.backgroundColor = AppConstants.F_RED_COLOR
            }
            else if indexPath.item == 3{
                cell.backgroundImageView.image = UIImage(named: "story")
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
                cell.smallIconImageView.image = UIImage(named: "relax")
                cell.backSmallImageView.backgroundColor = AppConstants.YELLOW_COLOR
            }
            //scell.backgroundColor = .red
            return cell
        }
        
        
        if collectionView == self.e_servicesCollectionView  {
            
            cellIdentifier = "servicesCell"
            
            
            let cell = e_servicesCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! e_servicesCollectionViewCell
            
            if indexPath.item == 0 {
                cell.serviceImageView.image = UIImage(named: "new_card")
                cell.serviceLabel.text = "Issuing People of Determination Cards"
                
            }else if indexPath.item == 1{
                cell.serviceImageView.image = UIImage(named: "renew_card")
                cell.serviceLabel.text = "Issuing Lost / damage Card for People of Determination"
               
            }else if indexPath.item == 2{
                cell.serviceImageView.image = UIImage(named: "new_card")
                cell.serviceLabel.text = "Renewing Card for People of Determination"
        
            }
            else if indexPath.item == 3{
                cell.serviceImageView.image = UIImage(named: "renew_card")
                cell.serviceLabel.text = "Recruitment Platform for People of Determination (Disabled) for Entities and Individuals"
                
            }else if indexPath.item == 4{
                cell.serviceImageView.image = UIImage(named: "new_card")
                cell.serviceLabel.text = "Registration in A Care & Rehabilitation Center for People of Determination"
                
            }else if indexPath.item == 5{
                cell.serviceImageView.image = UIImage(named: "renew_card")
                cell.serviceLabel.text = "Renewing Card"
                
            }
            
            
            //scell.backgroundColor = .red
            return cell
        }
        if collectionView == self.nemoCollectionView  {
            
            cellIdentifier = "nemoCell"
            
            
            let cell = nemoCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! nemoCollectionViewCell
            
           
            
            //scell.backgroundColor = .red
            return cell
        }
        if collectionView == self.medicalCollectionViewCell  {
            
            cellIdentifier = "nemoCell"
            
            
            let cell = medicalCollectionViewCell.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! nemoCollectionViewCell
            
            cell.progressLine.isHidden = true
            cell.childImageView.image = UIImage(named: "medical_assistant")
            cell.titleLabel.text = "My Medical Agenda"
            cell.descriptionLabel.text = "Four days left until your monthly medical checkup"
            cell.proceedButton.titleLabel?.text = "Reschedule"
            cell.progressHeight.constant = 0
            //scell.backgroundColor = .red
            return cell
        }
        if collectionView == self.wisdomCollectionViewCell  {
            
            cellIdentifier = "wisdomcell"
            
            
            let cell = wisdomCollectionViewCell.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! wisdomCollectionViewCell
            
            
            
            //scell.backgroundColor = .red
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == servicesCollectionView {
            
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
            /*
            if PFUser.current() == nil {
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
                
            }*/
        }else {
            self.performSegue(withIdentifier: "toEServices", sender: self)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == self.servicesCollectionView  {
            
            let padding: CGFloat =  20
            let size = self.servicesCollectionView.frame.size.width - padding
            var heightR = 0.0
            let collectionViewHeight = (collectionView.frame.height / 4) - 10
            let collectionViewWidth = Double(collectionView.frame.width - 20)
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
           
            return CGSize(width: 200 , height: 300)//width 200 // collectionViewWidth
            
            
            
        }
        if collectionView == self.e_servicesCollectionView  {
            
            
            
            return CGSize(width: 130 , height: 130)
            
        }
        if collectionView == self.nemoCollectionView  {
            
            
            return CGSize(width: collectionView.frame.width  , height: 120)
            
        }
        if collectionView == self.medicalCollectionViewCell  {
            
            
            return CGSize(width: collectionView.frame.width  , height: 120)
            
        }
        if collectionView == self.wisdomCollectionViewCell  {
            
            
            return CGSize(width: collectionView.frame.width - 10 , height: 150)
            
        }
        
        
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
