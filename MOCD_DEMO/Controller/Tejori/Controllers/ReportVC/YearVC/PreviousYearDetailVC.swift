//
//  PreviousYearDetailVC.swift
//  Edkhar
//
//  Created by indianic on 15/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD
import Charts
import Realm
import RealmSwift


class PreviousYearDetailVC: UIViewController,ChartViewDelegate {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    //-- View Expence Options -- //
    @IBOutlet weak var lblPExpIncomeValue: UILabel!
    
    
    @IBOutlet weak var lblPExpSpendingColour: UILabel!
    @IBOutlet weak var lblPExpSpendingValue: UILabel!
    
    @IBOutlet weak var lblPExpSavingColour: UILabel!
    @IBOutlet weak var lblPExpSavingValue: UILabel!
    
    @IBOutlet weak var lblPExpRemainingColour: UILabel!
    @IBOutlet weak var lblPExpRemainingValue: UILabel!
    //-- View Expence Options -- //
    
    //-- View Piecharts Options -- //
    @IBOutlet weak var viewPExpensesPieChart: PieChartView!
    @IBOutlet weak var viewPTargetSavingPieChart: BarChartView!
    @IBOutlet weak var viewPMostSpendingPieChart: PieChartView!
    @IBOutlet weak var viewPSpendingOptionPieChart: PieChartView!
    //-- View Piecharts Options -- //
    
    //-- View Saving Options -- //
    
    @IBOutlet weak var lblPSavingList1: UILabel!
    @IBOutlet weak var lblPSavingList1Colour: UILabel!
    @IBOutlet weak var lblPSavingList1Value: UILabel!
    
    @IBOutlet weak var lblPSavingList2: UILabel!
    @IBOutlet weak var lblPSavingList2Colour: UILabel!
    @IBOutlet weak var lblPSavingList2Value: UILabel!
    
    @IBOutlet weak var lblPSavingList3Colour: UILabel!
    @IBOutlet weak var lblPSavingList3: UILabel!
    @IBOutlet weak var lblPSavingList3Value: UILabel!
    
    @IBOutlet weak var lblPSavingOthersColour: UILabel!
    @IBOutlet weak var lblPSavingOthers: UILabel!
    @IBOutlet weak var lblPSavingOthersValue: UILabel!
    //-- View Saving Options -- //
    
    //-- ViewSpending Options -- //
    
    @IBOutlet weak var lblPSpendingOptLuxuryColour: UILabel!
    @IBOutlet weak var lblPSpendingOptLuxuryValue: UILabel!
    
    @IBOutlet weak var lblPSpendingOptNecessaryColour: UILabel!
    @IBOutlet weak var lblPSpendingOptNecessaryValue: UILabel!
    
    @IBOutlet weak var lblPSpendingOptNotDefinedColour: UILabel!
    @IBOutlet weak var lblPSpendingOptNotDefinedValue: UILabel!
    //-- ViewSpending Options -- //
    
    
    //-- View Av. Of Spending Weekly - monthly Options -- //
    @IBOutlet weak var lblPMostSpendingWeeklyValue: UILabel!
    @IBOutlet weak var lblPMostSpendingDailyValue: UILabel!
    @IBOutlet weak var lblPMostSpendingMonthlyValue: UILabel!
    //-- View Av. Of Spending Weekly - monthly Options -- //
    
    
    var aPTotalIncomeValue : Int = 0
    var aPTotalSpendingValue : Int = 0
    var aPTotalSavingValue : Int = 0
    
    
    var arrPTargetList = [TargetModel]()
    var arrPSavingList = [SavingModel]()
    
    var aSelectedYear = String()
    var objPreviousYearModel = PreviousYearModel()
    
    
    @IBOutlet weak var lblNoSavingGraph: UILabel!
    @IBOutlet weak var lblNoMostSpendingGraph: UILabel!
    
    var aMutArrPreviousYearList = [PreviousYearModel]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        axisFormatDelegate  = self
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        
        Utility.sharedInstance.customizeFonts(in: lblPExpIncomeValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPExpSpendingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPExpSavingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPExpRemainingValue, aFontName: Medium, aFontSize: 0)
        
        
        Utility.sharedInstance.customizeFonts(in: lblPSavingList1Value, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPSavingList2Value, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPSavingList3Value, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPSavingOthersValue, aFontName: Medium, aFontSize: 0)
        
        Utility.sharedInstance.customizeFonts(in: lblPSpendingOptLuxuryValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPSpendingOptNecessaryValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPSpendingOptNotDefinedValue, aFontName: Medium, aFontSize: 0)
        
        Utility.sharedInstance.customizeFonts(in: lblPMostSpendingWeeklyValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPMostSpendingDailyValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: lblPMostSpendingMonthlyValue, aFontName: SemiBold, aFontSize: 0)
        
        
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
        }
        else{
            btnBackAR.isHidden = true
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        
        DispatchQueue.main.async {
            Utility.sharedInstance.customizeFonts(in: self.lblScreenTitle, aFontName: Medium, aFontSize: 0)
            
            self.lblScreenTitle.text = self.aSelectedYear
        }
        
        // Do any additional setup after loading the view.
        
        
        viewPExpensesPieChart.drawSlicesUnderHoleEnabled = true
        viewPExpensesPieChart.drawCenterTextEnabled = true
        viewPExpensesPieChart.drawEntryLabelsEnabled = true
        viewPExpensesPieChart.highlightPerTapEnabled = false
        viewPExpensesPieChart.chartDescription?.text = ""
        viewPExpensesPieChart.holeRadiusPercent = 0.4
        viewPExpensesPieChart.legend.enabled = false
        viewPExpensesPieChart.noDataText = ""

        viewPTargetSavingPieChart.highlightPerTapEnabled = false
        viewPTargetSavingPieChart.chartDescription?.text = ""
        viewPTargetSavingPieChart.chartDescription?.enabled = false
        viewPTargetSavingPieChart.maxVisibleCount = 12
        viewPTargetSavingPieChart.legend.enabled = false
        viewPTargetSavingPieChart.rightAxis.enabled = false
        viewPTargetSavingPieChart.xAxis.labelPosition = .bottom
        
        
        viewPMostSpendingPieChart.drawSlicesUnderHoleEnabled = true
        viewPMostSpendingPieChart.drawCenterTextEnabled = false
        viewPMostSpendingPieChart.drawEntryLabelsEnabled = true
        viewPMostSpendingPieChart.highlightPerTapEnabled = false
        viewPMostSpendingPieChart.chartDescription?.text = ""
        viewPMostSpendingPieChart.holeRadiusPercent = 0
        viewPMostSpendingPieChart.drawHoleEnabled = false
        viewPMostSpendingPieChart.legend.enabled = false
        viewPMostSpendingPieChart.usePercentValuesEnabled = false
        
        viewPSpendingOptionPieChart.drawSlicesUnderHoleEnabled = true
        viewPSpendingOptionPieChart.drawCenterTextEnabled = true
        viewPSpendingOptionPieChart.drawEntryLabelsEnabled = true
        viewPSpendingOptionPieChart.highlightPerTapEnabled = false
        viewPSpendingOptionPieChart.chartDescription?.text = ""
        viewPSpendingOptionPieChart.holeRadiusPercent = 0.4
        viewPSpendingOptionPieChart.legend.enabled = false
        
        self.CalculateAllChartsData()
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func SetViewTargetSavingPieChart(values: [String], colours : [Double]) {
        
        let dollars = values
        let barMonths = colours
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<barMonths.count {

            let valueofX = Double(colours[i])
            let valueofY = Double(values[i])
            
            let dataEntry = BarChartDataEntry(x: valueofX, y: valueofY!)
            
            dataEntries.append(dataEntry)
            
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
        chartDataSet.drawValuesEnabled = false
        let chartData = BarChartData()
        
        chartData.addDataSet(chartDataSet)
        chartDataSet.setColor(UIColor(hex: GraphColour.kGreen.rawValue))
        
        
        var FontName = String()
        if (AppConstants.isArabic()) {
            FontName =  AppFonts.kGESSMedium.rawValue
        }else{
            FontName =  AppFonts.kMyriadProMedium.rawValue
        }
        
        viewPTargetSavingPieChart.data = chartData
        
        let xaxis = viewPTargetSavingPieChart.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        
        let Yaxis = viewPTargetSavingPieChart.leftAxis
        Yaxis.labelFont = UIFont.init(name: FontName, size: 12)!
        xaxis.labelFont = UIFont.init(name: FontName, size: 12)!
        
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
        
        viewPExpensesPieChart.data = pieChartData
        
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
        viewPMostSpendingPieChart.data = pieChartData
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
        
        viewPSpendingOptionPieChart.data = pieChartData
        
        pieChartDataSet.colors = colours
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
    }
    
    func CalculateAllChartsData() -> Void {
        
        SVProgressHUD.show()
        
        lblPExpSpendingColour.layer.masksToBounds = true
        lblPExpSpendingColour.layer.cornerRadius = 6
        lblPExpSpendingColour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
        
        lblPExpSavingColour.layer.masksToBounds = true
        lblPExpSavingColour.layer.cornerRadius = 6
        lblPExpSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        lblPExpRemainingColour.layer.masksToBounds = true
        lblPExpRemainingColour.layer.cornerRadius = 6
        lblPExpRemainingColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        // Expense
//        let aMutArrPreviousYearList = userInfoManager.sharedInstance.GetAllPreviousYearList(aYearNumber: aSelectedYear)
        aMutArrPreviousYearList.append(objPreviousYearModel)
        // Daily and weekly expense //
        
        if aMutArrPreviousYearList.count > 0 {
            
            var aTotalSpendingValue: Float = 0
            var aTotalIncomeValue: Float = 0
            var aTotalSavingValue: Float = 0
            var aTotalRemainingValue: Float = 0
            
            if aMutArrPreviousYearList.first?.totalSpending != nil {
                aTotalSpendingValue = (aMutArrPreviousYearList.first?.totalSpending!)!
            }
            
            if aMutArrPreviousYearList.first?.totalIncomes != nil {
                aTotalIncomeValue = (aMutArrPreviousYearList.first?.totalIncomes!)!
            }
            
            if aMutArrPreviousYearList.first?.totalSaving != nil {
                aTotalSavingValue = (aMutArrPreviousYearList.first?.totalSaving!)!
            }
            
            aTotalRemainingValue = Float(Float(aTotalIncomeValue) - (Float(aTotalSpendingValue) + Float(aTotalSavingValue)))
            
            // Total expense view calculation//
            
            self.lblPExpIncomeValue.text = String(aTotalIncomeValue)
            self.lblPExpSpendingValue.text = String(aTotalSpendingValue)
            self.lblPExpSavingValue.text = String(aTotalSavingValue)
            self.lblPExpRemainingValue.text = String(aTotalRemainingValue)
            
            var aSpendingPer : Float = 0
            var aRemaningPer : Float = 0
            var aSavingPer : Float = 0
            
            if aTotalIncomeValue != 0 {
                aSpendingPer = (Float(Float(aTotalSpendingValue * 100) / aTotalIncomeValue))
                aRemaningPer = (Float(Float((aTotalIncomeValue - aTotalSpendingValue) * 100) / aTotalIncomeValue))
                aSavingPer = (Float(Float(aTotalSavingValue * 100) / aTotalIncomeValue))
                
                let aViewSavingCalculation = [Double(aSpendingPer),Double(aSavingPer),Double(aRemaningPer)]
                
                
                let aColors = [UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
                
                var aPercentVal = Float(Float(aTotalSpendingValue * 100) / Float(aTotalIncomeValue))
                if aPercentVal > 100 {
                    aPercentVal = 100
                }
//                viewPExpensesPieChart.centerText = String.init(format: "%.1f %@",aPercentVal ,"%")
                
                let aCenterText = String.init(format: "%.1f %@",aPercentVal ,"%")
                var FontName = String()
                if (AppConstants.isArabic()) {
                    FontName =  AppFonts.kGESSMedium.rawValue
                }else{
                    FontName =  AppFonts.kMyriadProMedium.rawValue
                    
                }
                let myAttribute = [ NSAttributedString.Key.font: UIFont(name: FontName, size: 12.0)! ]
                
                let myAttrString = NSAttributedString(string: aCenterText, attributes: myAttribute)
                //                  viewExpensesPieChart.centerText = aCenterText
                viewPExpensesPieChart.centerAttributedText = myAttrString
                
                
                
                self.SetViewExpensesPieChart(values: aViewSavingCalculation, colours: aColors)

            }
            
            
            
            // Total expense view calculation //
            
            
            // Daily and weekly expense //
            let aCurrentMonth = Utility.sharedInstance.getMonthFromTodayDate()
            let aCurrentYear = Utility.sharedInstance.getYearFromTodayDate()
            
            var totalDaysTillToday : Int = 0
            for i in 1..<(aCurrentMonth+1) {
                let aCurrentMonthDays = Utility.sharedInstance.getNumberOfDaysInMonth(month: i, year: aCurrentYear)
                if i != aCurrentMonth {
                totalDaysTillToday = (totalDaysTillToday + aCurrentMonthDays)
                }
                else{
                    let aTodayDateNo = Utility.sharedInstance.getTodaysDaysFromTodayDateOfYear()
                    totalDaysTillToday = (totalDaysTillToday + aTodayDateNo)
                }
                
            }
            
            print("totalDaysTillToday = \(totalDaysTillToday)")
            
            let aDailySpendingValue = (Float(aTotalSpendingValue) / Float(totalDaysTillToday))
            
            let aWeeklySpendingValue = (Float(aTotalSpendingValue) / Float(Utility.sharedInstance.getWeekFromTodayDateOfYear()))
            
            
            let aMonthlySpendingValue = (Float(aTotalSpendingValue) / Float(Utility.sharedInstance.getMonthFromTodayDate()))
            
            print("Weekly Spending = \(String(format: "%.2f", aWeeklySpendingValue))")
            print("Daily Spending = \(String(format: "%.2f", aDailySpendingValue))")
            
            self.lblPMostSpendingWeeklyValue.text = String(format: "%.2f", aWeeklySpendingValue)
            self.lblPMostSpendingDailyValue.text = String(format: "%.2f", aDailySpendingValue)
            self.lblPMostSpendingMonthlyValue.text = String(format: "%.2f", aMonthlySpendingValue)
            
            // Daily and weekly expense //
            
        }
        
        
        // Saving List
        
        var aMonthlySavingValue = [String]()
        
        var aMonthNameValue = [Double]()
        
        for i in 1..<13 {
        
            if i < 10 {
                
                let amMnthValue = String.init(format: "0%d", i)
                
                let aMutArrPreviousYearSavingList = userInfoManagerT.sharedInstance.GetSavingListForYearByMonth(aYearNumber: aSelectedYear, aMonthNumber: amMnthValue)
                
                if aMutArrPreviousYearSavingList.count > 0{
                    
                    let targetValue = String((aMutArrPreviousYearSavingList.first?.target_total_saving_value)! as Float)
                    aMonthlySavingValue.append(targetValue)
                    
                    
                }else{
                    aMonthlySavingValue.append("0")
                }

                let varMonthValue = Double(i)
                aMonthNameValue.append(varMonthValue)
                
            }
            else{
                let aMutArrPreviousYearSavingList = userInfoManagerT.sharedInstance.GetSavingListForYearByMonth(aYearNumber: aSelectedYear, aMonthNumber: String(i))
                
                if aMutArrPreviousYearSavingList.count > 0{
                    
                    let targetValue = String((aMutArrPreviousYearSavingList.first?.target_total_saving_value)! as Float)
                    aMonthlySavingValue.append(targetValue)
                 
                    
                }else{
                    aMonthlySavingValue.append("0")
                }

                let varMonthValue = Double(i)
                aMonthNameValue.append(varMonthValue)
            }
            
        }
        
        print("aMonthlySavingValue = \(aMonthlySavingValue)")
        
        print("aMonthNameValue = \(aMonthNameValue)")
        
        self.SetViewTargetSavingPieChart(values: aMonthlySavingValue, colours: aMonthNameValue)
        
        
        
        // Most Spending Category
//        let aMutArrPreviousYearMostSpendingCategory = userInfoManager.sharedInstance.GetMostSpendingCategoryForYear(aYearNumber: aSelectedYear)
        
        
        // New Logic
        
        self.createTmpTableForMostSpendingCategoryYearly()
        
        let aCurrentYear = String(Utility.sharedInstance.getYearFromTodayDate())
        
        if aSelectedYear == aCurrentYear{
            let aCurrentMonth = Utility.sharedInstance.getMonthFromTodayDate()
            for i in 1...aCurrentMonth {
                var aStrMonth = String(i)
                if i < 10 {
                    aStrMonth  = String.init(format: "0%@", aStrMonth)
                }
                let aYearMonth = String.init(format: "%@-%@", aCurrentYear,aStrMonth)
                self.insertMostSpendingCategoryInTmpTable(aYearMonth: aYearMonth)
            }
        }
        else{
            for i in 1...12 {
                var aStrMonth = String(i)
                if i < 10 {
                    aStrMonth  = String.init(format: "0%@", aStrMonth)
                }
                let aYearMonth = String.init(format: "%@-%@", aSelectedYear,aStrMonth)
                self.insertMostSpendingCategoryInTmpTable(aYearMonth: aYearMonth)
            }
        }
        
        // New Logic
        
        
        
        // Most Spending Category
        //        let aMutArrPreviousYearMostSpendingCategory = userInfoManager.sharedInstance.GetMostSpendingCategoryForYear(aYearNumber: aSelectedYear)
        
        let aMutArrPreviousYearMostSpendingCategory = userInfoManagerT.sharedInstance.PYearMostSpendingCategoryList()
        self.deleteMostSpendingCategoryTmpTableData()
        
        lblNoMostSpendingGraph.isHidden = true
        viewPMostSpendingPieChart.isHidden = false
        if aMutArrPreviousYearMostSpendingCategory.count > 0 {
            
            print("spending_type_title = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_type_title!)")
            print("spending_type_title_ar = \(aMutArrPreviousYearMostSpendingCategory.first?.spending_type_title_ar!)")
            
            //--- Handle the graph for most spending category basis --- //
            
            
            
            // Calculate for Total income.
            
            var aaPTotalSpendingValue : Int = 0
            if aMutArrPreviousYearMostSpendingCategory.count > 0 {
                for i in 0...(aMutArrPreviousYearMostSpendingCategory.count - 1){
                    let aSpendingModel = aMutArrPreviousYearMostSpendingCategory[i]
                    aaPTotalSpendingValue += Int(aSpendingModel.spending_value!)
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
            viewPMostSpendingPieChart.isHidden = true
        }
        
        
        
        // --- Spending Type options -- //
        var arrSpendingList = [SpendingModel]()
        arrSpendingList = userInfoManagerT.sharedInstance.GetAllSpendingList()
        
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
                
                lblPSpendingOptLuxuryValue.text = String(aTotalSpendingOptionLuxury)
                
                let aSpendingOptionLuxuryPer = Double(Float(aTotalSpendingOptionLuxury * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = Double(aSpendingOptionLuxuryPer)
                
                let aColors = UIColor(hex: GraphColour.kGreen.rawValue)
                
                aViewSpendingOptionCalculation.append(aViewSpendingCateCalculation)
                aColorsList.append(aColors)
            }else{
                lblPSpendingOptLuxuryValue.text = "0"
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
                
                lblPSpendingOptNecessaryValue.text = String(aTotalSpendingOptionNecessary)
                
                let aSpendingOptionNecessaryPer = Double(Float(aTotalSpendingOptionNecessary * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = Double(aSpendingOptionNecessaryPer)
                
                let aColors = UIColor(hex: GraphColour.kYello.rawValue)
                
                aViewSpendingOptionCalculation.append(aViewSpendingCateCalculation)
                aColorsList.append(aColors)
                
            }else{
                lblPSpendingOptNecessaryValue.text = "0"
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
                
                lblPSpendingOptNotDefinedValue.text = String(aTotalSpendingOptionNotDefined)
                
                let aSpendingOptionNotDefinedPer = Double(Float(aTotalSpendingOptionNotDefined * 100) / Float(aaPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = Double(aSpendingOptionNotDefinedPer)
                
                let aColors = UIColor(hex: GraphColour.kBlue.rawValue)
                
                aViewSpendingOptionCalculation.append(aViewSpendingCateCalculation)
                aColorsList.append(aColors)
                
            }else{
                lblPSpendingOptNotDefinedValue.text = "0"
            }
            
            self.SetViewSpendingOptionsPieChart(values: aViewSpendingOptionCalculation, colours: aColorsList)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SVProgressHUD.dismiss()
            }
            
        }
        
        lblPSpendingOptLuxuryColour.layer.masksToBounds = true
        lblPSpendingOptLuxuryColour.layer.cornerRadius = 6
        lblPSpendingOptLuxuryColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        lblPSpendingOptNecessaryColour.layer.masksToBounds = true
        lblPSpendingOptNecessaryColour.layer.cornerRadius = 6
        lblPSpendingOptNecessaryColour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
        
        lblPSpendingOptNotDefinedColour.layer.masksToBounds = true
        lblPSpendingOptNotDefinedColour.layer.cornerRadius = 6
        lblPSpendingOptNotDefinedColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    func createTmpTableForMostSpendingCategoryYearly() -> Void {
        let tmpTableQuery = "CREATE TABLE IF NOT EXISTS most_spending_category (spending_id INTEGER, spending_date VARCHAR, spending_type_isrecurring VARCHAR , spending_type_title_en VARCHAR, spending_type_title_ar VARCHAR, spending_type_id_super INTEGER, spending_value VARCHAR)";
        _ = DatabaseEdkhar.sharedInstance.createTable(query: tmpTableQuery, success: {
            print("Table Created")
        }) {
            print("Table Creation Failed")
        }
    }
    
    func insertMostSpendingCategoryInTmpTable(aYearMonth: String) -> Void {
        let aInsertQuery = "INSERT INTO most_spending_category select spending_id,spending_date,spending_type_isrecurring,(select spending_type_title from spending_type where spending_type_id= (select case spending_type_super when 0 then s.spending_type_id else spending_type_super end from spending_type where spending_type_id= s.spending_type_id))spending_type_title_en,(select spending_type_title_ar from spending_type where spending_type_id= (select case spending_type_super when 0 then s.spending_type_id else spending_type_super end from spending_type where spending_type_id= s.spending_type_id))spending_type_title_ar,(select case spending_type_super when 0 then s.spending_type_id else spending_type_super end from spending_type where spending_type_id= s.spending_type_id) spending_type_id_super,spending_value  from spending s where (strftime('%Y-%m',spending_date)<='\(aYearMonth)' and spending_type_isrecurring =1) or (strftime('%Y-%m',spending_date) ='\(aYearMonth)' and spending_type_isrecurring =0)"
        _ = DatabaseEdkhar.sharedInstance.insert(query: aInsertQuery, success: {
        }, failure: {
        })
    }
    
    func deleteMostSpendingCategoryTmpTableData() -> Void {
        let aDeleteQuery = "Delete from most_spending_category"
        DatabaseEdkhar.sharedInstance.delete(query: aDeleteQuery, success: { (status) in
        }) { (status) in
        }
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

// MARK: axisFormatDelegate
extension PreviousYearDetailVC: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        switch value {
        case 1.0:
            if AppConstants.isArabic(){
                return "يناير"
            }else{
                return "JAN"
            }
            
        case 2.0:
            
            if AppConstants.isArabic(){
                return "فبراير"
            }else{
                return "FEB"
            }
        case 3.0:
            
            if AppConstants.isArabic(){
                return "مارس"
            }else{
                return "MAR"
            }
        case 4.0:
            
            if AppConstants.isArabic(){
                return "أبريل"
            }else{
                return "APR"
            }
        case 5.0:
            
            if AppConstants.isArabic(){
                return "مايو"
            }else{
                return "MAY"
            }
        case 6.0:
            
            if AppConstants.isArabic(){
                return "يونيو"
            }else{
                return "JUN"
            }
        case 7.0:
            
            if AppConstants.isArabic(){
                return "يوليو"
            }else{
                return "JUL"
            }
        case 8.0:
            
            if AppConstants.isArabic(){
                return "أغسطس"
            }else{
                return "AUG"
            }
        case 9.0:
            
            if AppConstants.isArabic(){
                return "سبتمبر"
            }else{
                return "SEP"
            }
        case 10.0:
            
            if AppConstants.isArabic(){
                return "أكتوبر"
            }else{
                return "OCT"
            }
        case 11.0:
            
            if AppConstants.isArabic(){
                return "نوفمبر"
            }else{
                return "NOV"
            }
        case 12.0:
            
            if AppConstants.isArabic(){
                return "ديسمبر"
            }else{
                return "DEC"
            }
            
        default:
            return ""
            
        }
    }
    
}
