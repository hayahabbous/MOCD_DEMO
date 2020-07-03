    //
//  CommanVC.swift
//  Edkhar
//
//  Created by indianic on 16/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class CommanVC: UIViewController {
    
    // MARK: - Properties & Outlets
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnRightMenu: UIButton!
    @IBOutlet weak var btnLeftMenu: UIButton!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var lblMonthYear: UILabel!
    @IBOutlet weak var btnMonthYear: UIButton!
    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var viewQuote: UIView!
    @IBOutlet weak var viewSpendingSaving: UIView!
    
    @IBOutlet weak var lblSpending: UILabel!
    @IBOutlet weak var lblSpendingValue: UILabel!
    
    @IBOutlet weak var lblSaving: UILabel!
    @IBOutlet weak var lblSavingValue: UILabel!
    
    @IBOutlet weak var lblCurrentIncome: UILabel!
    @IBOutlet weak var lblCurrentIncomeValue: UILabel!
    
    @IBOutlet weak var viewMonthPicker: UIView!
    @IBOutlet weak var monthPicker: MonthYearPickerView!
    
    var aMonth = Int()
    var aYear = Int()
    
    var objQuoteModel = QuoteModel()
    
    var isIncomeNotAdded = Bool()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.viewMonthPicker.isHidden = true
        
        self.LanguageSelectionMethod()
        
        Utility.sharedInstance.customizeFonts(in: monthPicker, aFontName: Medium, aFontSize: 0)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: monthPicker)
        
        monthPicker.onDateSelected = { (month: Int, year: Int) in
            self.aMonth = month
            self.aYear = year
        }
        
        
        if isIncomeNotAdded == true {
            self.isIncomeNotAdded = false
            let controller = UIAlertController(title: JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: "please insert your salary to get better advantage of the application", value: ""), preferredStyle: .alert)
            let addIncomeAction = UIAlertAction(title: JMOLocalizedString(forKey: "Add income", value: ""), style: .default, handler: { (action) in
                let aObjAddIncomeVC = self.storyboard?.instantiateViewController(withIdentifier: "AddIncomeVC") as! AddIncomeVC
                self.navigationController?.pushViewController(aObjAddIncomeVC, animated: true)
            })
            let cancelAction = UIAlertAction(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: .cancel, handler: { (action) in
                self.isIncomeNotAdded = false
            })
            controller.addAction(addIncomeAction)
            controller.addAction(cancelAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if aStrSelectedMonth == "" && aStrSelectedYear == "" {
         
            //Here I’m creating the calendar instance that we will operate with:
            let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
            
            //Now asking the calendar what month are we in today’s date:
            let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: Date()))
            
            //Now asking the calendar what year are we in today’s date:
            let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: Date()))
            
            if currentMonthInt! < 10{
                aStrSelectedMonth = String.init(format: "0%d",currentMonthInt!)
            }
            else{
                aStrSelectedMonth = String.init(format: "%d",currentMonthInt!)
            }
            aStrSelectedYear = String.init(format: "%d",currentYearInt!)
            
            if AppConstants.isArabic() {
                let aSelectedMonthYear = String.init(format: "%@ %d", GetMonthNameFromNumber(currentMonthInt!) , currentYearInt!)
                self.lblMonthYear.text = aSelectedMonthYear
            }else{
                let aSelectedMonthYear = String.init(format: "%@ %d", GetMonthNameFromNumber(currentMonthInt!) , currentYearInt!)
                self.lblMonthYear.text = aSelectedMonthYear
            }
            
            
        }else{
            let aSelectedMonthYear = String.init(format: "%@ %@", GetMonthNameFromNumber(Int(aStrSelectedMonth)!) , aStrSelectedYear)
            self.lblMonthYear.text = aSelectedMonthYear
    
        }
        
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            
            Utility.sharedInstance.customizeFonts(in: lblScreenTitle, aFontName: Light, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblMonthYear, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblQuote, aFontName: Medium, aFontSize: 0)
            
            Utility.sharedInstance.customizeFonts(in: lblSpending, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblSaving, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblCurrentIncome, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblSpendingValue, aFontName: SemiBold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblSavingValue, aFontName: SemiBold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblCurrentIncomeValue, aFontName: SemiBold, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: lblScreenTitle, aFontName: Light, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblMonthYear, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblQuote, aFontName: Medium, aFontSize: 0)
            
            Utility.sharedInstance.customizeFonts(in: lblSpending, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblSaving, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblCurrentIncome, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblSpendingValue, aFontName: SemiBold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblSavingValue, aFontName: SemiBold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblCurrentIncomeValue, aFontName: SemiBold, aFontSize: 0)
        }

        
        self.FetchTotalIncomeSpendingSaving()
        
        self.FetchQuoteOfWeek()
    }
    
    
    func FetchQuoteOfWeek() -> Void {
        
        let aQuoteOfWeekList = userInfoManagerT.sharedInstance.GetQuoteOfWeek()
        
        objQuoteModel = aQuoteOfWeekList.first as! QuoteModel
        let aQuoteEN = objQuoteModel.quote_en as! String
        let aQuoteAR = objQuoteModel.quote_ar as! String
        
        if AppConstants.isArabic() {
            self.lblQuote.text = aQuoteAR
        }else{
            self.lblQuote.text = aQuoteEN
        }
    }
    
    func FetchTotalIncomeSpendingSaving() -> Void {
        
        // Calculate for Total Spending.
        var aTotalSpendingValue = Double()
        let aArrAllSpendingModel : [SpendingModel] = userInfoManagerT.sharedInstance.GetAllSpendingList()
        if aArrAllSpendingModel.count > 0 {
            for i in 0...(aArrAllSpendingModel.count - 1){
                let aSpendingModel = aArrAllSpendingModel[i]
                if aSpendingModel.spending_value != "" {
                    aTotalSpendingValue += Double(aSpendingModel.spending_value as! String)!
                }
            }
        }
        self.lblSpendingValue.text = Utility.sharedInstance.convertDoubleToString(aStr: String(aTotalSpendingValue))
        
        
        
        // Calculate for Total Saving.
        var aTotalSavingValue = Double()
        let aArrAllSavingModel : [SavingModel] = userInfoManagerT.sharedInstance.GetAllSavingListTitle()
        if aArrAllSavingModel.count > 0 {
            for i in 0...(aArrAllSavingModel.count - 1){
                let aSavingModel = aArrAllSavingModel[i]
                if aSavingModel.saving_value != "" {
                    aTotalSavingValue += Double(aSavingModel.saving_value as! String)!
                }
            }
        }
        self.lblSavingValue.text = Utility.sharedInstance.convertDoubleToString(aStr: String(aTotalSavingValue))
        
        
        
        // Calculate for Current Income.
        let aArrAllIncomeModel : [IncomeModel] = userInfoManagerT.sharedInstance.GetAllIncomeList()
        var aTotalIncomeValue = Double()
        if aArrAllIncomeModel.count > 0 {
            for i in 0...(aArrAllIncomeModel.count - 1){
                let aIncomeModel = aArrAllIncomeModel[i]
                if aIncomeModel.income_value != "" {
                    aTotalIncomeValue += Double(aIncomeModel.income_value as! String)!
                }
            }
        }
        
        
        let aCurrentIncomeValue = (aTotalIncomeValue - (aTotalSpendingValue + aTotalSavingValue))
        self.lblCurrentIncomeValue.text = Utility.sharedInstance.convertDoubleToString(aStr: String(aCurrentIncomeValue))
        if aCurrentIncomeValue < 0 {
            self.lblCurrentIncomeValue.textColor = UIColor.red
            if appDelegate.ISIncomeMinusShown == false {
                Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "your total income will be in minus", value: ""))
                appDelegate.ISIncomeMinusShown = true
            }
        }else{
            self.lblCurrentIncomeValue.textColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1)
        }
        
    }
    
    // Mark :- Button Click Events
    
    func LanguageSelectionMethod() -> Void {
        /*
        if(AppConstants.isArabic())
        {
            self.btnLeftMenu.isHidden = true
            self.btnRightMenu.isHidden = false
        }
        else{
            self.btnLeftMenu.isHidden = false
            self.btnRightMenu.isHidden = true
        }*/
        
        btnRightMenu.titleLabel?.text = "Back"
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Edkhar", value: "")
    }
    
    @IBAction func btnMonthYearSelection(_ sender: UIButton) {
        
        self.viewMonthPicker.isHidden = false
        self.monthPicker.month = Int(aStrSelectedMonth)!
        self.monthPicker.year = Int(aStrSelectedYear)!
    }
    
    @IBAction func btnCancelPickerAction(_ sender: Any) {
    
        self.viewMonthPicker.isHidden = true
        
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        
        self.viewMonthPicker.isHidden = true
        
        if aMonth != 0 && aYear != 0 {
            if aMonth < 10{
                aStrSelectedMonth = String.init(format: "0%d",aMonth)
            }
            else{
                aStrSelectedMonth = String.init(format: "%d",aMonth)
            }
            
            aStrSelectedYear = String.init(format: "%d",aYear)
            let aSelectedMonthYear = String.init(format: "%@ %@", GetMonthNameFromNumber(aMonth) , aStrSelectedYear)
            self.lblMonthYear.text = aSelectedMonthYear
        }
        
        self.viewQuote.isHidden = false
        
        self.FetchTotalIncomeSpendingSaving()
        
        let aTabbarVC = self.children.first as! TabbarVCT?
        
        if aTabbarVC?.selectedIndex == 0 {
            let aIncomeVC = aTabbarVC?.children.first as! IncomeVC
            aIncomeVC.viewWillAppear(true)
        }
        else if aTabbarVC?.selectedIndex == 1 {
            let aSpendingVC = aTabbarVC?.children[1] as! SpendingVC
            aSpendingVC.viewWillAppear(true)
        }
        else if aTabbarVC?.selectedIndex == 2 {
            let aSavingVC = aTabbarVC?.children[2] as! SavingVC
            aSavingVC.viewWillAppear(true)
        }
        else if aTabbarVC?.selectedIndex == 3 {
            let aReportVC = aTabbarVC?.children[3] as! ReportVCT
            aReportVC.viewWillAppear(true)
        }
        
        
    }

    @IBAction func btnSideRightMenuAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        //appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
    }
    @IBAction func btnSideLeftMenuAction(_ sender: UIButton) {
        
        appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSeeMoreAction(_ sender: Any) {
        var aQuote:String = ""
        if AppConstants.isArabic(){
            aQuote = objQuoteModel.quote_ar as! String
        }else{
            aQuote = objQuoteModel.quote_en as! String
        }
        Utility.sharedInstance.showAlert(self, message: aQuote)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
