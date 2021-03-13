//
//  YearVC.swift
//  Edkhar
//
//  Created by indianic on 15/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import Charts

class YearVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblYearData: UITableView!
    var aMutArrPreviousYearList = [PreviousYearModel]()
    var aMutArrPreviousYearListUpdated = [PreviousYearModel]()
    var aMinimumYearTitleList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        // Expense
        if aMinimumYearTitleList.count < 0{
            aMinimumYearTitleList.removeAll()
        }
        
        let aMinimumYearList : [PreviousYearModel] = userInfoManagerT.sharedInstance.GetAllPreviousYearTitelList(aYearNumber: "")
        
        if aMinimumYearList.count > 0 {
            let aMinimumYear = Int((aMinimumYearList.first?.years!)!)
            var aCurrentYearVal = Utility.sharedInstance.getYearFromTodayDate()
            
            
            while (aCurrentYearVal) >= aMinimumYear! {
                
                print("aMinimumYear = \(aMinimumYear)")
                print("aCurrentYearVal = \(aCurrentYearVal)")
                
                var aTotalMonthViceIncome : Float = 0
                var aTotalMonthViceSpeding : Float = 0
                var aTotalMonthViceSaving : Float = 0
                
                let aYearTitle = String(aCurrentYearVal)
                
                let aCurrentYear = Utility.sharedInstance.getYearFromTodayDate()
                let aCurrentMonth = Utility.sharedInstance.getMonthFromTodayDate()
                
                if aYearTitle == String(aCurrentYear) {
                    
                    var aSelectedMonthValue = String()
                    
                    for i in 1...(aCurrentMonth) {
                        
                        if i < 10 {
                            aSelectedMonthValue = String.init(format: "0%d",i)
                        }else{
                            aSelectedMonthValue = String.init(format: "%d",i)
                        }
                        
                        let arrMutMonthlyExpenseList = userInfoManagerT.sharedInstance.GetPreviousMonthExpenseList(aMonth: aSelectedMonthValue, aYear:aYearTitle)
                        
                        if arrMutMonthlyExpenseList.count > 0 {
                            
                            let aTotalIncomeValue = arrMutMonthlyExpenseList.first?.income_value!
                            let aTotalSpendingValue = arrMutMonthlyExpenseList.first?.spending_value!
                            let aTotalSavingValue = arrMutMonthlyExpenseList.first?.saving_value!
                            
                            if aTotalIncomeValue != nil {
                                aTotalMonthViceIncome = (aTotalMonthViceIncome + aTotalIncomeValue!)
                            }
                            
                            if aTotalSpendingValue != nil {
                                aTotalMonthViceSpeding = (aTotalMonthViceSpeding + aTotalSpendingValue!)
                            }
                            
                            if aTotalSavingValue != nil {
                                aTotalMonthViceSaving = (aTotalMonthViceSaving + aTotalSavingValue!)
                            }
                        }
                        // == Saving list chart details == //
                    }
                    
                    
                    if ((aTotalMonthViceIncome != 0) || (aTotalMonthViceSpeding != 0) || (aTotalMonthViceSaving != 0)) {
                    
                        let aYearModel = PreviousYearModel()
                        aYearModel.years = aYearTitle
                        aYearModel.totalIncomes = aTotalMonthViceIncome
                        aYearModel.totalSpending = aTotalMonthViceSpeding
                        aYearModel.totalSaving = aTotalMonthViceSaving
                        
                        aMutArrPreviousYearListUpdated.append(aYearModel)
                    }
                    
                    
                    
                    
                }
                else{
                    
                    var aSelectedMonthValue = String()
                    
                    for i in 1...12 {
                        
                        if i < 10 {
                            aSelectedMonthValue = String.init(format: "0%d",i)
                        }else{
                            aSelectedMonthValue = String.init(format: "%d",i)
                        }
                        
                        
                        
                        let arrMutMonthlyExpenseList = userInfoManagerT.sharedInstance.GetPreviousMonthExpenseList(aMonth: aSelectedMonthValue, aYear:aYearTitle)
                        
                        if arrMutMonthlyExpenseList.count > 0 {
                            
                            let aTotalIncomeValue = arrMutMonthlyExpenseList.first?.income_value!
                            let aTotalSpendingValue = arrMutMonthlyExpenseList.first?.spending_value!
                            let aTotalSavingValue = arrMutMonthlyExpenseList.first?.saving_value!
                            
                            if aTotalIncomeValue != nil {
                                aTotalMonthViceIncome = (aTotalMonthViceIncome + aTotalIncomeValue!)
                            }
                            
                            if aTotalSpendingValue != nil {
                                aTotalMonthViceSpeding = (aTotalMonthViceSpeding + aTotalSpendingValue!)
                            }
                            
                            if aTotalSavingValue != nil {
                                aTotalMonthViceSaving = (aTotalMonthViceSaving + aTotalSavingValue!)
                            }
                            
                        }
                        
                        // == Saving list chart details == //
                    }
                    
                    
                    if ((aTotalMonthViceIncome != 0) || (aTotalMonthViceSpeding != 0) || (aTotalMonthViceSaving != 0)) {
                        
                        let aYearModel = PreviousYearModel()
                        aYearModel.years = aYearTitle
                        aYearModel.totalIncomes = aTotalMonthViceIncome
                        aYearModel.totalSpending = aTotalMonthViceSpeding
                        aYearModel.totalSaving = aTotalMonthViceSaving
                        
                        aMutArrPreviousYearListUpdated.append(aYearModel)
                    }
                    
                    
                    
                    
                }
                
                aCurrentYearVal = aCurrentYearVal - 1
                
                print("aMutArrPreviousYearListUpdated = \(aMutArrPreviousYearListUpdated)")
                
            }
            
            print("aMutArrPreviousYearListUpdated = \(aMutArrPreviousYearListUpdated)")
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aMutArrPreviousYearListUpdated.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aYearCell: YearCell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath) as! YearCell
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: aYearCell)
        
        aYearCell.lblYearSpendingColour.layer.masksToBounds = true
        aYearCell.lblYearSpendingColour.layer.cornerRadius = 7
        aYearCell.lblYearSpendingColour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
        
        aYearCell.lblYearSavingColour.layer.masksToBounds = true
        aYearCell.lblYearSavingColour.layer.cornerRadius = 7
        aYearCell.lblYearSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        aYearCell.lblYearRemainingColour.layer.masksToBounds = true
        aYearCell.lblYearRemainingColour.layer.cornerRadius = 7
        aYearCell.lblYearRemainingColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        
        aYearCell.viewYearPieChart.drawSlicesUnderHoleEnabled = true
        aYearCell.viewYearPieChart.drawCenterTextEnabled = true
        aYearCell.viewYearPieChart.drawEntryLabelsEnabled = true
        aYearCell.viewYearPieChart.highlightPerTapEnabled = false
        aYearCell.viewYearPieChart.chartDescription?.text = ""
        aYearCell.viewYearPieChart.holeRadiusPercent = 0.4
        aYearCell.viewYearPieChart.legend.enabled = false
        aYearCell.viewYearPieChart.noDataText = ""
        
        let aPreviousYearModel = aMutArrPreviousYearListUpdated[indexPath.row] as PreviousYearModel
        
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
        
        aTotalRemainingValue = (aTotalIncomeValue! - (aTotalSpendingValue! + aTotalSavingValue!))
        aYearCell.lblYearTitle.text = aMutArrPreviousYearListUpdated[indexPath.row].years
        aYearCell.lblYearIncomeValue.text =  String(aTotalIncomeValue!)
        aYearCell.lblYearSavingValue.text = String(aTotalSavingValue!)
        aYearCell.lblYearRemainingValue.text = String(aTotalRemainingValue)
        aYearCell.lblYearSpendingValue.text = String(aTotalSpendingValue!)
        
        Utility.sharedInstance.customizeFonts(in: aYearCell.lblYearTitle, aFontName: Medium, aFontSize: 0)
        
        Utility.sharedInstance.customizeFonts(in: aYearCell.lblYearIncomeValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aYearCell.lblYearSavingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aYearCell.lblYearRemainingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aYearCell.lblYearSpendingValue, aFontName: Medium, aFontSize: 0)
        
        if Float(aTotalIncomeValue!) > 0 {
            
            var aPercentVal = Float(Float(aTotalSpendingValue! * 100) / Float(aTotalIncomeValue!))
            if aPercentVal > 100 {
                aPercentVal = 100
            }
            
//            aYearCell.viewYearPieChart.centerText = String.init(format: "%.1f %@", aPercentVal,"%")
            
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
            aYearCell.viewYearPieChart.centerAttributedText = myAttrString

            
            
            let aViewSavingCalculation = [Double(aTotalSpending!),Double(aTotalSavingValue!),Double(aTotalIncome! - aTotalSavingValue!)]
            
            let aColors = [UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
            
            
            var dataEntries: [ChartDataEntry] = []
            
            for i in 0..<aViewSavingCalculation.count {
                
                let dataEntry = ChartDataEntry(x: aViewSavingCalculation[i], y: aViewSavingCalculation[i])
                
                dataEntries.append(dataEntry)
            }
            
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
            pieChartDataSet.drawValuesEnabled = false
            pieChartDataSet.selectionShift = 0
            
            let pieChartData = PieChartData(dataSets: [pieChartDataSet])
            
            aYearCell.viewYearPieChart.data = pieChartData
            
            pieChartDataSet.colors = aColors

        }
        
        
        return aYearCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aPreviousYearModel = aMutArrPreviousYearListUpdated[indexPath.row] as PreviousYearModel
        let aPreviousYearDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviousYearDetailVC") as! PreviousYearDetailVC
        aPreviousYearDetailVC.aSelectedYear = aMutArrPreviousYearListUpdated[indexPath.row].years
        aPreviousYearDetailVC.objPreviousYearModel = aPreviousYearModel
        self.navigationController?.pushViewController(aPreviousYearDetailVC, animated: true)
        
        //        self.performSegue(withIdentifier: "seguePreviousYearDetail", sender: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    
    
    //SELECT DISTINCT YEAR(created) FROM table
}
