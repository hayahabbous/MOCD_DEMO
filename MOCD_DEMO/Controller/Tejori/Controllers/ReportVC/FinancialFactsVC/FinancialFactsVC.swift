//
//  FinancialFactsVC.swift
//  Edkhar
//
//  Created by indianic on 15/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import Charts

class FinancialFactsVC: UIViewController {

    
    
    @IBOutlet weak var viewIncomeLifestyle: UIView!
    @IBOutlet weak var lblIncomeLifeStyle: UILabel!
    
    @IBOutlet weak var viewYourLifestyle: UIView!
    
    @IBOutlet weak var lblSpendingCate1: UILabel!
    @IBOutlet weak var lblSpendingCate1Value: UILabel!
    
    @IBOutlet weak var lblSpendingCate2: UILabel!
    @IBOutlet weak var lblSpendingCate2Value: UILabel!
    
    @IBOutlet weak var lblSpendingCate3: UILabel!
    @IBOutlet weak var lblSpendingCate3Value: UILabel!
    
    @IBOutlet weak var lblSpendingCate4: UILabel!
    @IBOutlet weak var lblSpendingCate4Value: UILabel!
    
    
    @IBOutlet weak var viewIncomeDistribution: UIView!
    @IBOutlet weak var viewPieIncomeDistribution: PieChartView!
    
    @IBOutlet weak var lblTotalSpendingColour: UILabel!
    @IBOutlet weak var lblTotalSpending: UILabel!
    @IBOutlet weak var lblTotalSpendingValue: UILabel!
    
    @IBOutlet weak var lblTotalSavingColour: UILabel!
    @IBOutlet weak var lblTotalSaving: UILabel!
    @IBOutlet weak var lblTotalSavingValue: UILabel!
    
    @IBOutlet weak var lblTotalIncomeColour: UILabel!
    @IBOutlet weak var lblTotalIncome: UILabel!
    @IBOutlet weak var lblTotalIncomeValue: UILabel!
    
    
    @IBOutlet weak var viewSpendingOption: UIView!
    @IBOutlet weak var viewPieChartSpendingType: PieChartView!
    
    @IBOutlet weak var lblLuzuryColour: UILabel!
    @IBOutlet weak var lblLuzuryValue: UILabel!
    
    @IBOutlet weak var lblNecessaryColour: UILabel!
    @IBOutlet weak var lblNecessaryValue: UILabel!
    
    @IBOutlet weak var lblNotDefinedColour: UILabel!
    @IBOutlet weak var lblNotDefinedValue: UILabel!
    
    @IBOutlet weak var viewMostSpendingMonth: UIView!
    @IBOutlet weak var lblMostSpendingMonthValue: UILabel!
    @IBOutlet weak var lblMostSpendingMonth: UILabel!
    
    var arrMutMostSpendingMonthlist = [MostSpendingMonthModel]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        Utility.sharedInstance.customizeFonts(in: lblIncomeLifeStyle, aFontName: SemiBold, aFontSize: 0)
        
        
        Utility.sharedInstance.customizeFonts(in: lblSpendingCate1Value, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSpendingCate2Value, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSpendingCate3Value, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSpendingCate4Value, aFontName: SemiBold, aFontSize: 0)
        
        
        Utility.sharedInstance.customizeFonts(in: lblLuzuryValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblNecessaryValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblNotDefinedValue, aFontName: Medium, aFontSize: 0)
        
        
        Utility.sharedInstance.customizeFonts(in: lblMostSpendingMonthValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblMostSpendingMonth, aFontName: SemiBold, aFontSize: 0)
        
        
        Utility.sharedInstance.customizeFonts(in: lblTotalSpendingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblTotalSavingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblTotalIncomeValue, aFontName: Medium, aFontSize: 0)
        
        
        

        

        // Do any additional setup after loading the view.
        
        lblTotalSpendingColour.layer.masksToBounds = true
        lblTotalSpendingColour.layer.cornerRadius = 6
        lblTotalSpendingColour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
        
        lblTotalSavingColour.layer.masksToBounds = true
        lblTotalSavingColour.layer.cornerRadius = 6
        lblTotalSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        lblTotalIncomeColour.layer.masksToBounds = true
        lblTotalIncomeColour.layer.cornerRadius = 6
        lblTotalIncomeColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        lblLuzuryColour.layer.masksToBounds = true
        lblLuzuryColour.layer.cornerRadius = 6
        lblLuzuryColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        lblNecessaryColour.layer.masksToBounds = true
        lblNecessaryColour.layer.cornerRadius = 6
        lblNecessaryColour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
        
        lblNotDefinedColour.layer.masksToBounds = true
        lblNotDefinedColour.layer.cornerRadius = 6
        lblNotDefinedColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        viewPieChartSpendingType.drawSlicesUnderHoleEnabled = true
        viewPieChartSpendingType.drawCenterTextEnabled = true
        viewPieChartSpendingType.drawEntryLabelsEnabled = true
        viewPieChartSpendingType.highlightPerTapEnabled = false
        viewPieChartSpendingType.chartDescription?.text = ""
        viewPieChartSpendingType.holeRadiusPercent = 0.4
        viewPieChartSpendingType.legend.enabled = false
        
        // -- Calculation for Suitable Income -- //
        
        let aCurrentYear = Utility.sharedInstance.getYearFromTodayDate()
        let aCurrentMonth = Utility.sharedInstance.getMonthFromTodayDate()
        var aStrSelectedMonth = String()
        var aTotalSutableIncome : Float = 0
        
        for i in 1...(aCurrentMonth) {
            
            if i < 10 {
                aStrSelectedMonth = String.init(format: "0%d",i)
            }else{
                aStrSelectedMonth = String.init(format: "%d",i)
            }
            
            let arrSuitableIncome = userInfoManagerT.sharedInstance.SuitableIncomeOfYear(aYear: String(aCurrentYear), aMonth: aStrSelectedMonth)
        
            if arrSuitableIncome.count > 0 {
            
                var aSuitableIncome = arrSuitableIncome.first?.spending_value
                print("SuitableIncome = \(aSuitableIncome)")
                
                if aSuitableIncome == nil {
                    aSuitableIncome = 0
                }
                
                aTotalSutableIncome = aTotalSutableIncome + aSuitableIncome!
            }
            
            
        }
        
        print("aTotalMonthViceIncome = \(aTotalSutableIncome)")
        
        let aSuitableIncomeValue = Float((Float(aTotalSutableIncome) / Float(aCurrentMonth
            )) * 1.2)
        print("aSuitableIncomeValue = \(aSuitableIncomeValue)")
        
        lblIncomeLifeStyle.text = String(aSuitableIncomeValue)
        
        
       
        // -- Calculation for Suitable Income -- //
        
        
        
        
        // -- Calculation for Spending Options -- //
        let arrMutSpendingTypes = userInfoManagerT.sharedInstance.GetSpendingTypeForYear(aYearNumber: String(Utility.sharedInstance.getYearFromTodayDate()))
        
        if arrMutSpendingTypes.count > 0 {
            
            let totalLuxury = arrMutSpendingTypes.first?.totalluxury
            let totalNecessary = arrMutSpendingTypes.first?.totalnecessary
            let totalNotDefined = arrMutSpendingTypes.first?.totalnotdefined
            
            let totalSpending = arrMutSpendingTypes.first?.totalspending
            
            print("totalLuxury = \(totalLuxury)")
            print("totalNecessary = \(totalNecessary)")
            print("totalNotDefined = \(totalNotDefined)")
            print("totalSpending = \(totalSpending)")
            
            lblLuzuryValue.text = String(totalLuxury!)
            lblNecessaryValue.text = String(totalNecessary!)
            lblNotDefinedValue.text = String(totalNotDefined!)
            
            let aSpendingOptionLuxuryPer = Double(Float(totalLuxury! * 100) / Float(totalSpending!))
            let aLuxuryColors = UIColor(hex: GraphColour.kGreen.rawValue)
            
            let aSpendingOptionNecessaryPer = Double(Float(totalNecessary! * 100) / Float(totalSpending!))
            let aNecessaryColors = UIColor(hex: GraphColour.kYello.rawValue)
            
            let aSpendingOptionNotDefinedPer = Double(Float(totalNotDefined! * 100) / Float(totalSpending!))
            let aNotDefinedColors = UIColor(hex: GraphColour.kBlue.rawValue)
            
            self.SetViewSpendingOptionsPieChart(values: [aSpendingOptionLuxuryPer,aSpendingOptionNecessaryPer,aSpendingOptionNotDefinedPer], colours: [aLuxuryColors,aNecessaryColors,aNotDefinedColors])
            
            
        }
        // -- Calculation for Spending Options -- //
        
        
        
        // -- Calculation for The Most Spending Month Options -- //
        
//        let aCurrentYear = Utility.sharedInstance.getYearFromTodayDate()
//        let aCurrentMonth = Utility.sharedInstance.getMonthFromTodayDate()
        
        
        var aSelectedMonthValue = String()
        
        for i in 1...(aCurrentMonth) {
            
            if i < 10 {
                aSelectedMonthValue = String.init(format: "0%d",i)
            }else{
                aSelectedMonthValue = String.init(format: "%d",i)
            }
        
            
            let arrIndividualSpendingMonth = userInfoManagerT.sharedInstance.MostSpendingMonthOfYear(aYear: String(aCurrentYear), aMonth: aSelectedMonthValue)
            
            if arrIndividualSpendingMonth.count > 0 {
                arrMutMostSpendingMonthlist.append(arrIndividualSpendingMonth.first!)
            }
            
        }
        
        let arrMutMostSpendingMonth = arrMutMostSpendingMonthlist.sorted { (objMostSpendingMonthModel1, objMostSpendingMonthModel2) -> Bool in
            return objMostSpendingMonthModel1.spending_value > objMostSpendingMonthModel2.spending_value
        }
        
        
        
        if arrMutMostSpendingMonth.count > 0 {
            
            var monthYear = arrMutMostSpendingMonth.first?.monthYear
            var spending_val = arrMutMostSpendingMonth.first?.spending_value
            
            var aStrYearValue = ""
            
        
            
            print("monthYear = \(monthYear)")
            print("spending_val = \(spending_val)")
            
            if monthYear == nil {
                monthYear = "N/A"
                lblMostSpendingMonth.text = monthYear!
            }else{
                aStrYearValue = (monthYear?.components(separatedBy: "-")[0])!
                let aStrMonthValue = Int((monthYear?.components(separatedBy: "-")[1])!)
                let aSelectedMonthYear = String.init(format: "%@ %@", GetMonthNameFromNumber(aStrMonthValue!) , aStrYearValue)
                
                lblMostSpendingMonth.text = aSelectedMonthYear
            }
            
            if spending_val == nil {
                spending_val = 0
            }
            
            lblMostSpendingMonthValue.text = String(spending_val!)
            
        }
        // -- Calculation for The Most Spending Month Options -- //
        
        
        
        
        // -- Calculation for The Income Distribution -- //
        
        
        viewPieIncomeDistribution.drawSlicesUnderHoleEnabled = true
        viewPieIncomeDistribution.drawCenterTextEnabled = true
        viewPieIncomeDistribution.drawEntryLabelsEnabled = true
        viewPieIncomeDistribution.highlightPerTapEnabled = false
        viewPieIncomeDistribution.chartDescription?.text = ""
        viewPieIncomeDistribution.holeRadiusPercent = 0.65
        viewPieIncomeDistribution.legend.enabled = false
        
        var aMutArrPreviousYearList = [FF_IncomeDistribution]()
        // Expense
        let aYear = Utility.sharedInstance.getYearFromTodayDate()
        aMutArrPreviousYearList = userInfoManagerT.sharedInstance.GetAllFFIncomeDistributionData(aYear: String(aYear))
        
        if aMutArrPreviousYearList.count > 0{
            
            let aPreviousYearModel = aMutArrPreviousYearList.first! as FF_IncomeDistribution
            
            var aTotalIncome = aPreviousYearModel.totalIncomes
            if aTotalIncome == nil {
                aTotalIncome = 0
            }
            
            var aTotalSpending = aPreviousYearModel.totalSpending
            if aTotalSpending == nil {
                aTotalSpending =  0
            }
            
            let aTotalSavingValue = aPreviousYearModel.totalSaving
            
            let aTotalIncomeValue = aTotalIncome
            
            let aTotalSpendingValue = aTotalSpending
            var aTotalRemainingValue : Float = 0
            
//            viewPieIncomeDistribution.centerText = String.init(format: "%@ \n %.1f",JMOLocalizedString(forKey: "Fixed income", value: ""), Float(aTotalIncomeValue!))
            
            let aCenterText = String.init(format: "%@ \n %.1f",JMOLocalizedString(forKey: "Fixed income", value: ""), Float(aTotalIncomeValue!))
            var FontName = String()
            if (AppConstants.isArabic()) {
                FontName =  AppFonts.kGESSMedium.rawValue
            }else{
                FontName =  AppFonts.kMyriadProMedium.rawValue
                
            }
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: FontName, size: 12.0)! ]
            
            let myAttrString = NSAttributedString(string: aCenterText, attributes: myAttribute)
            //                  viewExpensesPieChart.centerText = aCenterText
            viewPieIncomeDistribution.centerAttributedText = myAttrString

            
            
            aTotalRemainingValue = (aTotalIncomeValue! - (aTotalSpendingValue! + aTotalSavingValue!))
            
            
            //        lbl.text =  String(aTotalIncomeValue!)
            lblTotalSavingValue.text = String(aTotalSavingValue!)
            lblTotalIncomeValue.text = String(aTotalRemainingValue)
            lblTotalSpendingValue.text = String(aTotalSpendingValue!)
            
            let aViewIncomeDistributionCalculation = [Double(aTotalSpending!),Double(aTotalSavingValue!),Double(aTotalIncome! - aTotalSavingValue!)]
            
            let aIncomeDistrbutionColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
            
            
            self.SetViewIncomeDistributionPieChart(values: aViewIncomeDistributionCalculation, colours: aIncomeDistrbutionColors)
        }
        
        
        
        // -- Calculation for The Income Distribution -- //
        
        
        
        // -- most spending category -- //
        
        // Most Spending Category
    
        lblSpendingCate1.isHidden = true
        lblSpendingCate1Value.isHidden = true
        
        lblSpendingCate2.isHidden = true
        lblSpendingCate2Value.isHidden = true
        
        lblSpendingCate3.isHidden = true
        lblSpendingCate3Value.isHidden = true
        
        lblSpendingCate4.isHidden = true
        lblSpendingCate4Value.isHidden = true
        
        
        
        let aMutArrPreviousYearMostSpendingCategory = userInfoManagerT.sharedInstance.GetMostSpendingCategoryForYear(aYearNumber: String(aYear))
        
        if aMutArrPreviousYearMostSpendingCategory.count > 0 {
            
            print("spending_type_title = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_type_title!)")
            print("spending_type_title_ar = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_type_title_ar!)")
//            print("spending_date = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_date!)")
            print("spending_value = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_value!)")
            
            
            //--- Handle the graph for most spending category basis --- //
            
            
            if aMutArrPreviousYearMostSpendingCategory.count == 1 {
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
//                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aaPTotalSpendingValue))
                
//                let aViewSpendingCateCalculation = [Double(aSpending1Per)]
                
//                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue)]
                
                var aaSpendingCateTitles = String()
                
                if AppConstants.isArabic(){
                    aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title_ar!
                }
                else{
                    aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title!
                }
                
                
                lblSpendingCate1.isHidden = false
                lblSpendingCate1Value.isHidden = false
                
                lblSpendingCate2.isHidden = true
                lblSpendingCate2Value.isHidden = true
                
                lblSpendingCate3.isHidden = true
                lblSpendingCate3Value.isHidden = true
                
                lblSpendingCate4.isHidden = true
                lblSpendingCate4Value.isHidden = true
                
                lblSpendingCate1.text = aaSpendingCateTitles
                lblSpendingCate1Value.text = String(aSpendingCate1Value)
                
            }
            else if aMutArrPreviousYearMostSpendingCategory.count == 2 {
                

                
                lblSpendingCate1.isHidden = false
                lblSpendingCate1Value.isHidden = false
                
                lblSpendingCate2.isHidden = false
                lblSpendingCate2Value.isHidden = false
                
                lblSpendingCate3.isHidden = true
                lblSpendingCate3Value.isHidden = true
                
                lblSpendingCate4.isHidden = true
                lblSpendingCate4Value.isHidden = true

                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpendingCate2Value = Int(aMutArrPreviousYearMostSpendingCategory[1].spending_value)

                
                var aaSpendingCateTitles1 = String()
                var aaSpendingCateTitles2 = String()
                
                if AppConstants.isArabic(){
                    aaSpendingCateTitles1 = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title_ar!
                    aaSpendingCateTitles2 = aMutArrPreviousYearMostSpendingCategory[1].spending_type_title_ar!
                }
                else{
                    aaSpendingCateTitles1 = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title!
                    aaSpendingCateTitles2 = aMutArrPreviousYearMostSpendingCategory[1].spending_type_title!
                }
                
                lblSpendingCate1.text = aaSpendingCateTitles1
                lblSpendingCate1Value.text = String(aSpendingCate1Value)
                
                lblSpendingCate2.text = aaSpendingCateTitles2
                lblSpendingCate2Value.text = String(aSpendingCate2Value)
                
                
            }
            else if aMutArrPreviousYearMostSpendingCategory.count == 3 {
                
                lblSpendingCate1.isHidden = false
                lblSpendingCate1Value.isHidden = false
                
                lblSpendingCate2.isHidden = false
                lblSpendingCate2Value.isHidden = false
                
                lblSpendingCate3.isHidden = false
                lblSpendingCate3Value.isHidden = false
                
                lblSpendingCate4.isHidden = true
                lblSpendingCate4Value.isHidden = true
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpendingCate2Value = Int(aMutArrPreviousYearMostSpendingCategory[1].spending_value)
                let aSpendingCate3Value = Int(aMutArrPreviousYearMostSpendingCategory[2].spending_value)
                
                
                var aaSpendingCateTitles1 = String()
                var aaSpendingCateTitles2 = String()
                var aaSpendingCateTitles3 = String()
                
                if AppConstants.isArabic(){
                    aaSpendingCateTitles1 = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title_ar!
                    aaSpendingCateTitles2 = aMutArrPreviousYearMostSpendingCategory[1].spending_type_title_ar!
                    aaSpendingCateTitles3 = aMutArrPreviousYearMostSpendingCategory[2].spending_type_title_ar!
                }
                else{
                    aaSpendingCateTitles1 = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title!
                    aaSpendingCateTitles2 = aMutArrPreviousYearMostSpendingCategory[1].spending_type_title!
                    aaSpendingCateTitles3 = aMutArrPreviousYearMostSpendingCategory[2].spending_type_title!
                }
                
                lblSpendingCate1.text = aaSpendingCateTitles1
                lblSpendingCate1Value.text = String(aSpendingCate1Value)
                
                lblSpendingCate2.text = aaSpendingCateTitles2
                lblSpendingCate2Value.text = String(aSpendingCate2Value)
                
                lblSpendingCate3.text = aaSpendingCateTitles3
                lblSpendingCate3Value.text = String(aSpendingCate3Value)
                
            }
            else if aMutArrPreviousYearMostSpendingCategory.count >= 4 {
                
                lblSpendingCate1.isHidden = false
                lblSpendingCate1Value.isHidden = false
                
                lblSpendingCate2.isHidden = false
                lblSpendingCate2Value.isHidden = false
                
                lblSpendingCate3.isHidden = false
                lblSpendingCate3Value.isHidden = false
                
                lblSpendingCate4.isHidden = false
                lblSpendingCate4Value.isHidden = false
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpendingCate2Value = Int(aMutArrPreviousYearMostSpendingCategory[1].spending_value)
                let aSpendingCate3Value = Int(aMutArrPreviousYearMostSpendingCategory[2].spending_value)
                let aSpendingCate4Value = Int(aMutArrPreviousYearMostSpendingCategory[3].spending_value)
                
                
                var aaSpendingCateTitles1 = String()
                var aaSpendingCateTitles2 = String()
                var aaSpendingCateTitles3 = String()
                var aaSpendingCateTitles4 = String()
                
                if AppConstants.isArabic(){
                    aaSpendingCateTitles1 = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title_ar!
                    aaSpendingCateTitles2 = aMutArrPreviousYearMostSpendingCategory[1].spending_type_title_ar!
                    aaSpendingCateTitles3 = aMutArrPreviousYearMostSpendingCategory[2].spending_type_title_ar!
                    aaSpendingCateTitles4 = aMutArrPreviousYearMostSpendingCategory[3].spending_type_title_ar!
                }
                else{
                    aaSpendingCateTitles1 = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title!
                    aaSpendingCateTitles2 = aMutArrPreviousYearMostSpendingCategory[1].spending_type_title!
                    aaSpendingCateTitles3 = aMutArrPreviousYearMostSpendingCategory[2].spending_type_title!
                    aaSpendingCateTitles4 = aMutArrPreviousYearMostSpendingCategory[3].spending_type_title!
                }
                
                lblSpendingCate1.text = aaSpendingCateTitles1
                lblSpendingCate1Value.text = String(aSpendingCate1Value)
                
                lblSpendingCate2.text = aaSpendingCateTitles2
                lblSpendingCate2Value.text = String(aSpendingCate2Value)
                
                lblSpendingCate3.text = aaSpendingCateTitles3
                lblSpendingCate3Value.text = String(aSpendingCate3Value)
                
                lblSpendingCate4.text = aaSpendingCateTitles4
                lblSpendingCate4Value.text = String(aSpendingCate4Value)
                
            }
            
            
           
            
            //--- Handle the graph for most spending category basis --- //
            
        }
        
        
        // -- most spending category -- //
    }
    
    func SetViewIncomeDistributionPieChart(values: [Double], colours : [UIColor]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            
            let dataEntry = ChartDataEntry(x: values[i], y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.selectionShift = 0
        
        
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
        viewPieIncomeDistribution.data = pieChartData
        
        pieChartDataSet.colors = colours
        
    }

    func SetViewSpendingOptionsPieChart(values: [Double], colours : [UIColor]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            
            let dataEntry = ChartDataEntry(x: values[i], y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.selectionShift = 0
        
        
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
        viewPieChartSpendingType.data = pieChartData
        
        pieChartDataSet.colors = colours
        
        
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


