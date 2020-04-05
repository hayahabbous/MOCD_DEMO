//
//  SavingVC.swift
//  Edkhar
//
//  Created by indianic on 30/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class ReportVCT: UIViewController {

    @IBOutlet weak var reportContainerView: UIView!
    @IBOutlet weak var btnFinancialFacts: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnPreviousMonth: UIButton!
    @IBOutlet weak var btnCurrentMonth: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Do any additional setup after loading the view.
        
        let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
        var indexComman : Int = 0
        for objViewcontoller in arrNavigationArr.viewControllers {
            if objViewcontoller is CommanVC {
                indexComman = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                break
            }
        }
        
        let objCommanVC = arrNavigationArr.viewControllers[indexComman] as! CommanVC
        objCommanVC.viewQuote.isHidden = true
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        self.btnCurrentMonthAction(btnCurrentMonth)
    }
    
//    private func add(asChildViewController viewController: UIViewController) {
//        
//        // Add Child View as Subview
//        view.addSubview(viewController.view)
//        
//        // Configure Child View
//        viewController.view.frame = view.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        // Notify Child View Controller
//        self.addChildViewController(aPreviousMonthVC!)
//        viewController.didMove(toParentViewController: self)
//        
//    }
    
    @IBAction func btnCurrentMonthAction(_ sender: UIButton) {
        
        btnCurrentMonth.backgroundColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1.0)
        btnPreviousMonth.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnYear.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnFinancialFacts.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        
        let aCurrentMonthVC = self.storyboard?.instantiateViewController(withIdentifier: "CurrentMonthVC") as! CurrentMonthVC?
        aCurrentMonthVC?.view.frame = CGRect.init(x: 0, y: 0, width: self.reportContainerView.frame.size.width, height: self.reportContainerView.frame.size.height)
        // Add Child View Controller
        self.reportContainerView.addSubview((aCurrentMonthVC?.view)!)
        self.addChild(aCurrentMonthVC!)
        aCurrentMonthVC?.didMove(toParent: self)
        
        
    }
    
    @IBAction func btnPreviousMonthAction(_ sender: UIButton) {
        
        btnCurrentMonth.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnPreviousMonth.backgroundColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1.0)
        btnYear.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnFinancialFacts.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)

        let aPreviousMonthVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviousMonthVC") as! PreviousMonthVC?
        aPreviousMonthVC?.view.frame = CGRect.init(x: 0, y: 0, width: self.reportContainerView.frame.size.width, height: self.reportContainerView.frame.size.height)
        self.reportContainerView.addSubview((aPreviousMonthVC?.view)!)
        self.addChild(aPreviousMonthVC!)
        aPreviousMonthVC?.didMove(toParent: self)
        
    }
    
    @IBAction func btnFinancialFactsAction(_ sender: UIButton) {
        
        btnCurrentMonth.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnPreviousMonth.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnYear.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnFinancialFacts.backgroundColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1.0)
        
        let aFinancialFactsVC = self.storyboard?.instantiateViewController(withIdentifier: "FinancialFactsVC") as! FinancialFactsVC?
        aFinancialFactsVC?.view.frame = CGRect.init(x: 0, y: 0, width: self.reportContainerView.frame.size.width, height: self.reportContainerView.frame.size.height)
        self.reportContainerView.addSubview((aFinancialFactsVC?.view)!)
        self.addChild(aFinancialFactsVC!)
        aFinancialFactsVC?.didMove(toParent: self)
        
    }
    @IBAction func btnYearAction(_ sender: UIButton) {
        
        btnCurrentMonth.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnPreviousMonth.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        btnYear.backgroundColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1.0)
        btnFinancialFacts.backgroundColor = UIColor.colorFromRGB(R: 1, G: 94, B: 51, Alpha: 1.0)
        
        let aYearVC = self.storyboard?.instantiateViewController(withIdentifier: "YearVC") as! YearVC?
        aYearVC?.view.frame = CGRect.init(x: 0, y: 0, width: self.reportContainerView.frame.size.width, height: self.reportContainerView.frame.size.height)
        self.reportContainerView.addSubview((aYearVC?.view)!)
        self.addChild(aYearVC!)
        aYearVC?.didMove(toParent: self)
        
    }
    @IBAction func btnSideRightMenuAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        //appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
    }
    
    @IBAction func btnSideLeftMenuAction(_ sender: UIButton) {
        
        appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
