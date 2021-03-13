//
//  CurrentMonthVC.swift
//  Edkhar
//
//  Created by indianic on 15/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD
import Charts

class CurrentMonthVC: UIViewController {
    
    //-- View Expence Options -- //
    @IBOutlet weak var viewExpenses: UIView!
    @IBOutlet weak var lblExpIncome: UILabel!
    @IBOutlet weak var lblExpIncomeValue: UILabel!
    
    @IBOutlet weak var lblExpSpending: UILabel!
    @IBOutlet weak var lblExpSpendingColour: UILabel!
    @IBOutlet weak var lblExpSpendingValue: UILabel!
    
    @IBOutlet weak var lblExpSaving: UILabel!
    @IBOutlet weak var lblExpSavingColour: UILabel!
    @IBOutlet weak var lblExpSavingValue: UILabel!
    
    @IBOutlet weak var lblExpRemaining: UILabel!
    @IBOutlet weak var lblExpRemainingColour: UILabel!
    @IBOutlet weak var lblExpRemainingValue: UILabel!
    //-- View Expence Options -- //
    
    //-- View Piecharts Options -- //
    @IBOutlet weak var viewExpensesPieChart: PieChartView!
    @IBOutlet weak var viewTargetSavingPieChart: PieChartView!
    @IBOutlet weak var viewMostSpendingPieChart: PieChartView!
    @IBOutlet weak var viewSpendingOptionPieChart: PieChartView!
    //-- View Piecharts Options -- //
    
    //-- View Saving Options -- //
    @IBOutlet weak var viewSaving: UIView!
    
    @IBOutlet weak var lblSavingList1: UILabel!
    @IBOutlet weak var lblSavingList1Colour: UILabel!
    @IBOutlet weak var lblSavingList1Value: UILabel!
    
    @IBOutlet weak var lblSavingList2: UILabel!
    @IBOutlet weak var lblSavingList2Colour: UILabel!
    @IBOutlet weak var lblSavingList2Value: UILabel!
    
    @IBOutlet weak var lblSavingList3Colour: UILabel!
    @IBOutlet weak var lblSavingList3: UILabel!
    @IBOutlet weak var lblSavingList3Value: UILabel!
    
    @IBOutlet weak var lblSavingOthersColour: UILabel!
    @IBOutlet weak var lblSavingOthers: UILabel!
    @IBOutlet weak var lblSavingOthersValue: UILabel!
    //-- View Saving Options -- //
    
    //-- ViewSpending Options -- //
    @IBOutlet weak var lblSpendingOptLuxury: UILabel!
    @IBOutlet weak var lblSpendingOptLuxuryColour: UILabel!
    @IBOutlet weak var lblSpendingOptLuxuryValue: UILabel!
    
    @IBOutlet weak var lblSpendingOptNecessary: UILabel!
    @IBOutlet weak var lblSpendingOptNecessaryColour: UILabel!
    @IBOutlet weak var lblSpendingOptNecessaryValue: UILabel!
    
    @IBOutlet weak var lblSpendingOptNotDefined: UILabel!
    @IBOutlet weak var lblSpendingOptNotDefinedColour: UILabel!
    @IBOutlet weak var lblSpendingOptNotDefinedValue: UILabel!
    //-- ViewSpending Options -- //
    
    
    //-- View Av. Of Spending Weekly - monthly Options -- //
    @IBOutlet weak var lblMostSpendingWeeklyValue: UILabel!
    @IBOutlet weak var lblMostSpendingDailyValue: UILabel!
    //-- View Av. Of Spending Weekly - monthly Options -- //
    
    
    var aTotalIncomeValue : Int = 0
    var aTotalSpendingValue : Int = 0
    var aTotalSavingValue : Int = 0
    
    
    var arrTargetList = [TargetModel]()
    var arrSavingList = [SavingModel]()
    
    @IBOutlet weak var lblNoSavingGraph: UILabel!
    @IBOutlet weak var lblNoMostSpendingGraph: UILabel!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        Utility.sharedInstance.customizeFonts(in: lblExpIncomeValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblExpSpendingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblExpSavingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblExpRemainingValue, aFontName: Medium, aFontSize: 0)
        
        
        Utility.sharedInstance.customizeFonts(in: lblSavingList1Value, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSavingList2Value, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSavingList3Value, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSavingOthersValue, aFontName: Medium, aFontSize: 0)
        
        Utility.sharedInstance.customizeFonts(in: lblSpendingOptLuxuryValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSpendingOptNecessaryValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblSpendingOptNotDefinedValue, aFontName: Medium, aFontSize: 0)
        
        Utility.sharedInstance.customizeFonts(in: lblMostSpendingWeeklyValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblMostSpendingDailyValue, aFontName: SemiBold, aFontSize: 0)
        
        
        
        
        
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
        
        self.ViewExpensesCalculation()
        

        // Do any additional setup after loading the view.
        
        
        viewExpensesPieChart.drawSlicesUnderHoleEnabled = true
        viewExpensesPieChart.drawCenterTextEnabled = true
        viewExpensesPieChart.drawEntryLabelsEnabled = true
        viewExpensesPieChart.highlightPerTapEnabled = false
        viewExpensesPieChart.chartDescription?.text = ""
        viewExpensesPieChart.holeRadiusPercent = 0.4
        viewExpensesPieChart.legend.enabled = false
        viewExpensesPieChart.noDataText = ""
        

        viewTargetSavingPieChart.drawSlicesUnderHoleEnabled = true
        viewTargetSavingPieChart.drawCenterTextEnabled = true
        viewTargetSavingPieChart.drawEntryLabelsEnabled = true
        viewTargetSavingPieChart.highlightPerTapEnabled = false
        viewTargetSavingPieChart.chartDescription?.text = ""
        viewTargetSavingPieChart.holeRadiusPercent = 0.4
        viewTargetSavingPieChart.legend.enabled = false
        
        viewMostSpendingPieChart.drawSlicesUnderHoleEnabled = true
        viewMostSpendingPieChart.drawCenterTextEnabled = false
        viewMostSpendingPieChart.drawEntryLabelsEnabled = true
        viewMostSpendingPieChart.highlightPerTapEnabled = false
        viewMostSpendingPieChart.chartDescription?.text = ""
        viewMostSpendingPieChart.holeRadiusPercent = 0
        viewMostSpendingPieChart.drawHoleEnabled = false
        viewMostSpendingPieChart.legend.enabled = false
        viewMostSpendingPieChart.usePercentValuesEnabled = false
        
        viewMostSpendingPieChart.noDataText =  JMOLocalizedString(forKey: "You did not enter any spending yet!", value: "")
        
        viewSpendingOptionPieChart.drawSlicesUnderHoleEnabled = true
        viewSpendingOptionPieChart.drawCenterTextEnabled = true
        viewSpendingOptionPieChart.drawEntryLabelsEnabled = true
        viewSpendingOptionPieChart.highlightPerTapEnabled = false
        viewSpendingOptionPieChart.chartDescription?.text = ""
        viewSpendingOptionPieChart.holeRadiusPercent = 0.4
        viewSpendingOptionPieChart.legend.enabled = false

        viewSpendingOptionPieChart.noDataText =  JMOLocalizedString(forKey: "You did not enter any spending yet!", value: "")
        
    }
    
    
    func SetViewTargetSavingPieChart(values: [Double], colours : [UIColor]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {

            let dataEntry = ChartDataEntry(x: values[i], y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.selectionShift = 0

        
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
        viewTargetSavingPieChart.data = pieChartData
        
        pieChartDataSet.colors = colours
    
        
    }
    
    
    func SetViewExpensesPieChart(values: [Double], colours : [UIColor]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            
            let dataEntry = ChartDataEntry(x: values[i], y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        
        
        
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.selectionShift = 0
        
       
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
        viewExpensesPieChart.data = pieChartData

        if (AppConstants.isArabic()) {
            viewExpensesPieChart.data?.setValueFont(UIFont (name: AppFonts.kGESSMedium.rawValue, size: 12)!)
        }else{
            viewExpensesPieChart.data?.setValueFont(UIFont (name: AppFonts.kMyriadProMedium.rawValue, size: 12)!)
        }
        
        pieChartDataSet.colors = colours
        
    }
    
    func SetViewMostExpensesCategoryPieChart(values: [Double], colours : [UIColor], spendingTypeTitleList: [String]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            
            let dataEntry = PieChartDataEntry(value: values[i], label: spendingTypeTitleList[i])
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        pieChartDataSet.drawValuesEnabled = true
        pieChartDataSet.selectionShift = 0
        
        pieChartDataSet.colors = colours
        
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
        pieChartDataSet.valueLinePart1Length = 0.2
        pieChartDataSet.valueLinePart2Length = 1
        pieChartDataSet.yValuePosition = .outsideSlice
        pieChartDataSet.xValuePosition = .outsideSlice
        
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        viewMostSpendingPieChart.data = pieChartData
        
        pieChartData.setValueTextColor(.black)
        var FontName = String()
        if (AppConstants.isArabic()) {
            FontName =  AppFonts.kGESSMedium.rawValue
        }else{
            FontName =  AppFonts.kMyriadProMedium.rawValue
        }
        pieChartData.setValueFont(UIFont.init(name: FontName, size: 12)!)
        
        let format = NumberFormatter()
        format.numberStyle = .none
        format.numberStyle = .percent
        format.maximumFractionDigits = 0
        format.multiplier = 1
        format.percentSymbol = "%"
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
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
        
        viewSpendingOptionPieChart.data = pieChartData
        
        pieChartDataSet.colors = colours
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
    }

    
    func ViewExpensesCalculation() -> Void {
        
        SVProgressHUD.show()
        
        self.setExpenseChartData()
        
        lblExpSpendingColour.layer.masksToBounds = true
        lblExpSpendingColour.layer.cornerRadius = 6
        lblExpSpendingColour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
        
        lblExpSavingColour.layer.masksToBounds = true
        lblExpSavingColour.layer.cornerRadius = 6
        lblExpSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        lblExpRemainingColour.layer.masksToBounds = true
        lblExpRemainingColour.layer.cornerRadius = 6
        lblExpRemainingColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
    }
    
    func setExpenseChartData() -> Void {
        
        let aSelectedMonth = Utility.sharedInstance.getMonthFromTodayDate()
        var aSelectedMonthValue = String()
        
        if aSelectedMonth < 10{
            aSelectedMonthValue = String.init(format: "0%d",aSelectedMonth)
        }
        else{
            aSelectedMonthValue = String.init(format: "%d",aSelectedMonth)
        }
        
        let aSelectedYearValue = Utility.sharedInstance.getYearFromTodayDate()
        
        let arrMutMonthlyExpenseList = userInfoManagerT.sharedInstance.GetPreviousMonthExpenseList(aMonth: aSelectedMonthValue, aYear: String(aSelectedYearValue))
        
        if arrMutMonthlyExpenseList.count > 0 {
            
            let aTotalSpendingValue = arrMutMonthlyExpenseList.first?.spending_value!
            let aTotalIncomeValue = arrMutMonthlyExpenseList.first?.income_value!
            let aTotalSavingValue = arrMutMonthlyExpenseList.first?.saving_value!
            //            let aTotalRemainingValue = arrMutMonthlyExpenseList.first?.remainingIncome!
            let aTotalRemainingValue = (aTotalIncomeValue! - (aTotalSpendingValue! + aTotalSavingValue!))
            
            SVProgressHUD.show()
            
            lblExpSpendingColour.layer.masksToBounds = true
            lblExpSpendingColour.layer.cornerRadius = 6
            lblExpSpendingColour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
            
            lblExpSavingColour.layer.masksToBounds = true
            lblExpSavingColour.layer.cornerRadius = 6
            lblExpSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
            
            lblExpRemainingColour.layer.masksToBounds = true
            lblExpRemainingColour.layer.cornerRadius = 6
            lblExpRemainingColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
            
            
            // Total expense view calculation//
            
            self.lblExpIncomeValue.text = String(aTotalIncomeValue!)
            self.lblExpSpendingValue.text = String(aTotalSpendingValue!)
            self.lblExpSavingValue.text = String(aTotalSavingValue!)
            self.lblExpRemainingValue.text = String(aTotalRemainingValue)
            
            var aSpendingPer : Float = 0
            var aRemaningPer : Float = 0
            var aSavingPer : Float = 0
            
            if aTotalIncomeValue != 0 {
                aSpendingPer = (Float(Float(aTotalSpendingValue! * 100) / aTotalIncomeValue!))
                aRemaningPer = (Float(Float((aTotalIncomeValue! - aTotalSpendingValue!) * 100) / aTotalIncomeValue!))
                aSavingPer = (Float(Float(aTotalSavingValue! * 100) / aTotalIncomeValue!))
                
                let aViewSavingCalculation = [Double(aSpendingPer),Double(aSavingPer),Double(aRemaningPer)]
                
                
                let aColors = [UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
                
                var aPercentVal = Float(Float(aTotalSpendingValue! * 100) / Float(aTotalIncomeValue!))
                if aPercentVal > 100 {
                    aPercentVal = 100
                }
                
                let aCenterText = String.init(format: "%.1f %@", aPercentVal,"%")
                var FontName = String()
                if (AppConstants.isArabic()) {
                    FontName =  AppFonts.kGESSMedium.rawValue
                }else{
                    FontName =  AppFonts.kMyriadProMedium.rawValue
                    
                }
                let myAttribute = [ NSAttributedString.Key.font: UIFont(name: FontName, size: 12.0)! ]
                
                let myAttrString = NSAttributedString(string: aCenterText, attributes: myAttribute)
//                  viewExpensesPieChart.centerText = aCenterText
                viewExpensesPieChart.centerAttributedText = myAttrString
                
                self.SetViewExpensesPieChart(values: aViewSavingCalculation, colours: aColors)

            }
            
            
            // Total expense view calculation //
            
            // Daily and weekly expense //
            let aWeeklySpendingValue = Float(Float(aTotalSpendingValue!) / Float(Utility.sharedInstance.getWeekFromTodayDate()))
            let aDailySpendingValue = Float(Float(aTotalSpendingValue!) / Float(Utility.sharedInstance.getDayFromTodayDate()))
            
            
            print("Weekly Spending = \(String(format: "%.2f", aWeeklySpendingValue))")
            print("Daily Spending = \(String(format: "%.2f", aDailySpendingValue))")
            
            self.lblMostSpendingWeeklyValue.text = String(format: "%.2f", aWeeklySpendingValue)
            self.lblMostSpendingDailyValue.text = String(format: "%.2f", aDailySpendingValue)
            
            // Daily and weekly expense //
            
        }
        
        
        // == Saving list chart details == //
        
        // Saving List
        let aMutArrPreviousYearSavingList = userInfoManagerT.sharedInstance.GetPreviousMonthSavingList(aMonth: aSelectedMonthValue, aYear: String(aSelectedYearValue))
        
        
        lblNoSavingGraph.isHidden = true
        viewTargetSavingPieChart.isHidden = false
        if aMutArrPreviousYearSavingList.count > 0 {
         
            if aMutArrPreviousYearSavingList.count == 1 {
                
                lblSavingList1.isHidden = false
                lblSavingList1Colour.isHidden = false
                lblSavingList1Value.isHidden = false
                
                lblSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblSavingList2.isHidden = true
                lblSavingList2Colour.isHidden = true
                lblSavingList2Value.isHidden = true
                
                
                lblSavingList3.isHidden = true
                lblSavingList3Colour.isHidden = true
                lblSavingList3Value.isHidden = true
                
                
                lblSavingOthers.isHidden = true
                lblSavingOthersColour.isHidden = true
                lblSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                let aPTotalSavingValue = (aSaving1Value)
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                
                let aViewSavingCalculation = [Double(aSaving1Per)]
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue)]
                
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
                
            }
            else if aMutArrPreviousYearSavingList.count == 2 {
                
                lblSavingList1.isHidden = false
                lblSavingList1Colour.isHidden = false
                lblSavingList1Value.isHidden = false
                lblSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblSavingList2.isHidden = false
                lblSavingList2Colour.isHidden = false
                lblSavingList2Value.isHidden = false
                lblSavingList2.text = aMutArrPreviousYearSavingList[1].target_name!
                lblSavingList2Value.text = String(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                lblSavingList3.isHidden = true
                lblSavingList3Colour.isHidden = true
                lblSavingList3Value.isHidden = true
                
                lblSavingOthers.isHidden = true
                lblSavingOthersColour.isHidden = true
                lblSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                let aSaving2Value = Int(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                let aPTotalSavingValue = (aSaving1Value + aSaving2Value)
                
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                let aSaving2Per = Double(Float(aSaving2Value) / Float(aPTotalSavingValue) * 100)
                
                
                
                let aViewSavingCalculation = [Double(aSaving1Per),Double(aSaving2Per)]
                
                
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
                
            }
            else if aMutArrPreviousYearSavingList.count == 3 {
                
                lblSavingList1.isHidden = false
                lblSavingList1Colour.isHidden = false
                lblSavingList1Value.isHidden = false
                lblSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblSavingList2.isHidden = false
                lblSavingList2Colour.isHidden = false
                lblSavingList2Value.isHidden = false
                lblSavingList2.text = aMutArrPreviousYearSavingList[1].target_name!
                lblSavingList2Value.text = String(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                lblSavingList3.isHidden = false
                lblSavingList3Colour.isHidden = false
                lblSavingList3Value.isHidden = false
                lblSavingList3.text = aMutArrPreviousYearSavingList[2].target_name!
                lblSavingList3Value.text = String(aMutArrPreviousYearSavingList[2].target_total_saving_value!)
                
                lblSavingOthers.isHidden = true
                lblSavingOthersColour.isHidden = true
                lblSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                let aSaving2Value = Int(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                let aSaving3Value = Int(aMutArrPreviousYearSavingList[2].target_total_saving_value!)
                
                let aPTotalSavingValue = (aSaving1Value + aSaving2Value + aSaving3Value)
                
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                let aSaving2Per = Double(Float(aSaving2Value) / Float(aPTotalSavingValue) * 100)
                let aSaving3Per = Double(Float(aSaving3Value) / Float(aPTotalSavingValue) * 100)
                
                
                let aViewSavingCalculation = [Double(aSaving1Per),Double(aSaving2Per),Double(aSaving3Per)]
                
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kOrange.rawValue)]
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
            }
            else if aMutArrPreviousYearSavingList.count >= 4 {
                
                lblSavingList1.isHidden = false
                lblSavingList1Colour.isHidden = false
                lblSavingList1Value.isHidden = false
                lblSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblSavingList2.isHidden = false
                lblSavingList2Colour.isHidden = false
                lblSavingList2Value.isHidden = false
                lblSavingList2.text = aMutArrPreviousYearSavingList[1].target_name!
                lblSavingList2Value.text = String(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                lblSavingList3.isHidden = false
                lblSavingList3Colour.isHidden = false
                lblSavingList3Value.isHidden = false
                lblSavingList3.text = aMutArrPreviousYearSavingList[2].target_name!
                lblSavingList3Value.text = String(aMutArrPreviousYearSavingList[2].target_total_saving_value!)
                
                lblSavingOthers.isHidden = false
                lblSavingOthersColour.isHidden = false
                lblSavingOthersValue.isHidden = false
                
                lblSavingOthers.text = JMOLocalizedString(forKey: "Other:", value: "")
                var aTotalOtherValue = Int()
                for i in 3...(aMutArrPreviousYearSavingList.count - 1){
                    aTotalOtherValue = aTotalOtherValue + Int(aMutArrPreviousYearSavingList[i].target_total_saving_value!)
                }
                lblSavingOthersValue.text = String(aTotalOtherValue)
                
                
                let aSaving1Value = Int(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                let aSaving2Value = Int(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                let aSaving3Value = Int(aMutArrPreviousYearSavingList[2].target_total_saving_value!)
                let aSavingOtherValue = Int(aMutArrPreviousYearSavingList[3].target_total_saving_value!)
                
                let aPTotalSavingValue = (aSaving1Value + aSaving2Value + aSaving3Value + aSavingOtherValue)
                
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                let aSaving2Per = Double(Float(aSaving2Value) / Float(aPTotalSavingValue) * 100)
                let aSaving3Per = Double(Float(aSaving3Value) / Float(aPTotalSavingValue) * 100)
                let aSavingOtherPer = Double(Float(aSavingOtherValue) / Float(aPTotalSavingValue) * 100)
                
                let aViewSavingCalculation = [Double(aSaving1Per),Double(aSaving2Per),Double(aSaving3Per),Double(aSavingOtherPer)]
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kBlue.rawValue)]
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
            }
            
            lblSavingList1Colour.layer.masksToBounds = true
            lblSavingList1Colour.layer.cornerRadius = 6
            lblSavingList1Colour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
            
            lblSavingList2Colour.layer.masksToBounds = true
            lblSavingList2Colour.layer.cornerRadius = 6
            lblSavingList2Colour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
            
            lblSavingList3Colour.layer.masksToBounds = true
            lblSavingList3Colour.layer.cornerRadius = 6
            lblSavingList3Colour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
            
            lblSavingOthersColour.layer.masksToBounds = true
            lblSavingOthersColour.layer.cornerRadius = 6
            lblSavingOthersColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
            
            
        }
        else{
            lblSavingList1.isHidden = true
            lblSavingList1Colour.isHidden = true
            lblSavingList1Value.isHidden = true
            
            lblSavingList2.isHidden = true
            lblSavingList2Colour.isHidden = true
            lblSavingList2Value.isHidden = true
            
            lblSavingList3.isHidden = true
            lblSavingList3Colour.isHidden = true
            lblSavingList3Value.isHidden = true
            
            lblSavingOthers.isHidden = true
            lblSavingOthersColour.isHidden = true
            lblSavingOthersValue.isHidden = true
            
            
            lblNoSavingGraph.isHidden = false
            viewTargetSavingPieChart.isHidden = true
            
        }
        
        // == Saving list chart details == //
        
        
        
        
        
        
        // = most spending category chart details  == //
        
        // Most Spending Category
//        aSelectedMonthValue, aYear: String(aSelectedYearValue))
        let aMutArrPreviousYearMostSpendingCategory = userInfoManagerT.sharedInstance.GetPreviousMonthMostSpendingCategoryList(aMonth: aSelectedMonthValue, aYear: String(aSelectedYearValue))
        lblNoMostSpendingGraph.isHidden = true
        viewMostSpendingPieChart.isHidden = false
        if aMutArrPreviousYearMostSpendingCategory.count > 0 {
            
            print("spending_type_title = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_type_title!)")
            print("spending_type_title_ar = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_type_title_ar!)")
            //            print("spending_date = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_date!)")
            print("spending_value = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_value!)")
            
            
            //--- Handle the graph for most spending category basis --- //
            
            
            
            // Calculate for Total income.
            
            var aaPTotalSpendingValue : Int = 0
            if aMutArrPreviousYearMostSpendingCategory.count > 0 {
                for i in 0...(aMutArrPreviousYearMostSpendingCategory.count - 1){
                    let aSpendingModel = aMutArrPreviousYearMostSpendingCategory[i]
                    aaPTotalSpendingValue += Int(aSpendingModel.spending_value)
                }
            }
            
            
            if aMutArrPreviousYearMostSpendingCategory.count == 1 {
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue)]
                
                var aaSpendingCateTitles = String()
                
                if AppConstants.isArabic(){
                    aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title_ar!
                }
                else{
                    aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[0].spending_type_title!
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors, spendingTypeTitleList: [aaSpendingCateTitles])
                
            }
            else if aMutArrPreviousYearMostSpendingCategory.count == 2 {
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aaPTotalSpendingValue))
                
                let aSpendingCate2Value = Int(aMutArrPreviousYearMostSpendingCategory[1].spending_value)
                let aSpending2Per = Double(Float(aSpendingCate2Value * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per),Double(aSpending2Per)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kBlue.rawValue)]
                
                
                var aaSpendingCateTitleslist = [String]()
                
                if aMutArrPreviousYearMostSpendingCategory.count > 0 {
                    
                    for i in 0...(aMutArrPreviousYearMostSpendingCategory.count - 1){
                        
                        var aaSpendingCateTitles = String()
                        
                        if AppConstants.isArabic(){
                            aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[i].spending_type_title_ar!
                        }
                        else{
                            aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[i].spending_type_title!
                        }
                        
                        aaSpendingCateTitleslist.append(aaSpendingCateTitles)
                    }
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors,spendingTypeTitleList:aaSpendingCateTitleslist)
                
            }
            else if aMutArrPreviousYearMostSpendingCategory.count == 3 {
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aaPTotalSpendingValue))
                
                let aSpendingCate2Value = Int(aMutArrPreviousYearMostSpendingCategory[1].spending_value)
                let aSpending2Per = Double(Float(aSpendingCate2Value * 100) / Float(aaPTotalSpendingValue))
                
                let aSpendingCate3Value = Int(aMutArrPreviousYearMostSpendingCategory[2].spending_value)
                let aSpending3Per = Double(Float(aSpendingCate3Value * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per),Double(aSpending2Per),Double(aSpending3Per)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kOrange.rawValue)]
                
                var aaSpendingCateTitleslist = [String]()
                
                if aMutArrPreviousYearMostSpendingCategory.count > 0 {
                    
                    for i in 0...(aMutArrPreviousYearMostSpendingCategory.count - 1){
                        
                        var aaSpendingCateTitles = String()
                        
                        if AppConstants.isArabic(){
                            aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[i].spending_type_title_ar!
                        }
                        else{
                            aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[i].spending_type_title!
                        }
                        
                        aaSpendingCateTitleslist.append(aaSpendingCateTitles)
                    }
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors,spendingTypeTitleList:aaSpendingCateTitleslist)
                
            }
            else if aMutArrPreviousYearMostSpendingCategory.count >= 4 {
                
                let aSpendingCate1Value = Int(aMutArrPreviousYearMostSpendingCategory[0].spending_value)
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aaPTotalSpendingValue))
                
                let aSpendingCate2Value = Int(aMutArrPreviousYearMostSpendingCategory[1].spending_value)
                let aSpending2Per = Double(Float(aSpendingCate2Value * 100) / Float(aaPTotalSpendingValue))
                
                let aSpendingCate3Value = Int(aMutArrPreviousYearMostSpendingCategory[2].spending_value)
                let aSpending3Per = Double(Float(aSpendingCate3Value * 100) / Float(aaPTotalSpendingValue))
                
                let aSpendingCateOtherValue = Int(aMutArrPreviousYearMostSpendingCategory[3].spending_value)
                let aSpendingOtherPer = Double(Float(aSpendingCateOtherValue * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per),Double(aSpending2Per),Double(aSpending3Per),Double(aSpendingOtherPer)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kYello.rawValue)]
                
                
                var aaSpendingCateTitleslist = [String]()
                
                if aMutArrPreviousYearMostSpendingCategory.count > 0 {
                    
                    for i in 0...(aMutArrPreviousYearMostSpendingCategory.count - 1){
                        
                        var aaSpendingCateTitles = String()
                        
                        if AppConstants.isArabic(){
                            aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[i].spending_type_title_ar!
                        }
                        else{
                            aaSpendingCateTitles = aMutArrPreviousYearMostSpendingCategory[i].spending_type_title!
                        }
                        
                        if ( i != (aMutArrPreviousYearMostSpendingCategory.count - 1)){
                            aaSpendingCateTitleslist.append(aaSpendingCateTitles)
                        }else{
                            aaSpendingCateTitleslist.append(JMOLocalizedString(forKey: "Others", value: ""))
                        }
                        
                    }
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors,spendingTypeTitleList:aaSpendingCateTitleslist)
                
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SVProgressHUD.dismiss()
            }
            
            //--- Handle the graph for most spending category basis --- //
            
            
            
        }
        else{
            lblNoMostSpendingGraph.isHidden = false
            viewMostSpendingPieChart.isHidden = true
        }
        
        // = most spending category chart details  == //
        
        
        
        
        
        
        
        // = most spending options chart details  == //
        
        var arrSpendingList = [SpendingModel]()
        
//        aSelectedMonthValue, aYear: String(aSelectedYearValue)
        
        arrSpendingList = userInfoManagerT.sharedInstance.GetAllSpendingListByProvidedMonthYear(aSelectedMonth: aSelectedMonthValue, aSelectedYear: String(aSelectedYearValue))
        
        if arrSpendingList.count > 0{
            
            
            // Calculate for Total income.
            
            var aaPTotalSpendingValue : Int = 0
            if arrSpendingList.count > 0 {
                for i in 0...(arrSpendingList.count - 1){
                    let aSpendingModel = arrSpendingList[i]
                    aaPTotalSpendingValue += Int(aSpendingModel.spending_value as! String)!
                }
            }
            
            var aViewSpendingOptionCalculation = [Double]()
            
            var aColorsList = [UIColor]()
            
            
            let aSpendingOptionLuxuryFilterlist = arrSpendingList.filter({ (objSpendingModel) -> Bool in
                return objSpendingModel.spending_option == 1
            })
            
            let aSpendingOptionNecessaryFilterlist = arrSpendingList.filter({ (objSpendingModel) -> Bool in
                return objSpendingModel.spending_option == 2
            })
            
            let aSpendingOptionNotDefinedFilterlist = arrSpendingList.filter({ (objSpendingModel) -> Bool in
                return objSpendingModel.spending_option == 3
            })
            
            if aSpendingOptionLuxuryFilterlist.count > 0 {
                
                var aTotalSpendingOptionLuxury = Double()
                if aSpendingOptionLuxuryFilterlist.count > 0 {
                    for i in 0...(aSpendingOptionLuxuryFilterlist.count - 1){
                        let objSpendingModel = aSpendingOptionLuxuryFilterlist[i]
                        aTotalSpendingOptionLuxury += Double(objSpendingModel.spending_value as! String)!
                    }
                }
                
                print("aTotalSpendingOptionLuxury = \(aTotalSpendingOptionLuxury)")
                
                lblSpendingOptLuxuryValue.text = String(aTotalSpendingOptionLuxury)
                
                let aSpendingOptionLuxuryPer = Double(Float(aTotalSpendingOptionLuxury * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = Double(aSpendingOptionLuxuryPer)
                
                let aColors = UIColor(hex: GraphColour.kGreen.rawValue)
                
                aViewSpendingOptionCalculation.append(aViewSpendingCateCalculation)
                aColorsList.append(aColors)
            }else{
                lblSpendingOptLuxuryValue.text = "0"
            }
            
            if aSpendingOptionNecessaryFilterlist.count > 0 {
                
                var aTotalSpendingOptionNecessary = Double()
                
                if aSpendingOptionNecessaryFilterlist.count > 0 {
                    for i in 0...(aSpendingOptionNecessaryFilterlist.count - 1){
                        let objSpendingModel = aSpendingOptionNecessaryFilterlist[i]
                        aTotalSpendingOptionNecessary += Double(objSpendingModel.spending_value as! String)!
                    }
                }
                
                print("aTotalSpendingOptionNecessary = \(aTotalSpendingOptionNecessary)")
                
                lblSpendingOptNecessaryValue.text = String(aTotalSpendingOptionNecessary)
                
                let aSpendingOptionNecessaryPer = Double(Float(aTotalSpendingOptionNecessary * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = Double(aSpendingOptionNecessaryPer)
                
                let aColors = UIColor(hex: GraphColour.kYello.rawValue)
                
                aViewSpendingOptionCalculation.append(aViewSpendingCateCalculation)
                aColorsList.append(aColors)
                
            }else{
                lblSpendingOptNecessaryValue.text = "0"
            }
            
            
            if aSpendingOptionNotDefinedFilterlist.count > 0 {
                
                var aTotalSpendingOptionNotDefined = Double()
                
                if aSpendingOptionNotDefinedFilterlist.count > 0 {
                    for i in 0...(aSpendingOptionNotDefinedFilterlist.count - 1){
                        let objSpendingModel = aSpendingOptionNotDefinedFilterlist[i]
                        aTotalSpendingOptionNotDefined += Double(objSpendingModel.spending_value as! String)!
                    }
                }
                
                print("aTotalSpendingOptionNotDefined = \(aTotalSpendingOptionNotDefined)")
                
                lblSpendingOptNotDefinedValue.text = String(aTotalSpendingOptionNotDefined)
                
                let aSpendingOptionNotDefinedPer = Double(Float(aTotalSpendingOptionNotDefined * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = Double(aSpendingOptionNotDefinedPer)
                
                let aColors = UIColor(hex: GraphColour.kBlue.rawValue)
                
                aViewSpendingOptionCalculation.append(aViewSpendingCateCalculation)
                aColorsList.append(aColors)
                
            }else{
                lblSpendingOptNotDefinedValue.text = "0"
            }
            
            self.SetViewSpendingOptionsPieChart(values: aViewSpendingOptionCalculation, colours: aColorsList)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SVProgressHUD.dismiss()
            }
            
        }
        
        lblSpendingOptLuxuryColour.layer.masksToBounds = true
        lblSpendingOptLuxuryColour.layer.cornerRadius = 6
        lblSpendingOptLuxuryColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        lblSpendingOptNecessaryColour.layer.masksToBounds = true
        lblSpendingOptNecessaryColour.layer.cornerRadius = 6
        lblSpendingOptNecessaryColour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
        
        lblSpendingOptNotDefinedColour.layer.masksToBounds = true
        lblSpendingOptNotDefinedColour.layer.cornerRadius = 6
        lblSpendingOptNotDefinedColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        
        // = most spending options chart details  == //
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
        
    }
}
