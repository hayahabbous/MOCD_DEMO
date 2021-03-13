//
//  PreviousMonthVC.swift
//  Edkhar
//
//  Created by indianic on 15/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD
import Charts

class PreviousMonthVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblPreviousMonths: UITableView!
    
    var arrPreviousMonthList = [PreviousMonthModel]()
    var arrPreviousMonthNewData = [PreviousMonthModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPreviousMonths.delegate = self
        tblPreviousMonths.dataSource = self
        
        self.GetTotalSpendingDetailsByMonth()
        
    }
    
    func GetTotalSpendingDetailsByMonth() -> Void {
        
        let aCurrentYear = Utility.sharedInstance.getYearFromTodayDate()
        var aCurrentMonth = Utility.sharedInstance.getMonthFromTodayDate()
        
        var aSelectedMonthValue = String()

                
        while aCurrentMonth >=  1{
            if aCurrentMonth < 10 {
                aSelectedMonthValue = String.init(format: "0%d",aCurrentMonth)
            }else{
                aSelectedMonthValue = String.init(format: "%d",aCurrentMonth)
            }
            
            let arrPreviousMonthList = userInfoManagerT.sharedInstance.GetAllPreviousMonthList(aMonth: aSelectedMonthValue, aYear: String(aCurrentYear))
            
            if arrPreviousMonthList.count > 0 {
                
                let objPreviousMonthModel : PreviousMonthModel = arrPreviousMonthList.first!
                
                let aTotalMonthViceIncome = objPreviousMonthModel.totalIncome
                let aTotalMonthViceSpeding = objPreviousMonthModel.totalSpending
                let aTotalMonthViceSaving = objPreviousMonthModel.totalSaving
                
                if ((aTotalMonthViceIncome != 0) || (aTotalMonthViceSpeding != 0) || (aTotalMonthViceSaving != 0)) {
                    arrPreviousMonthNewData.append(arrPreviousMonthList.first!)
                }
            }
            
            aCurrentMonth = aCurrentMonth - 1
        }
      
        if arrPreviousMonthNewData.count > 0 {
            tblPreviousMonths.reloadData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        LanguageManager.sharedInstance.localizeThingsInView(parentView: tblPreviousMonths)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPreviousMonthNewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aPreviousMonthCell = tblPreviousMonths.dequeueReusableCell(withIdentifier: "PreviousMonthCell") as! PreviousMonthCell
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: aPreviousMonthCell)
        
        let aPreviousMonthModel = arrPreviousMonthNewData[indexPath.row] as PreviousMonthModel
        
        let aStrYearValue = aPreviousMonthModel.monthsYear.components(separatedBy: "-")[0]
        let aStrMonthValue = Int(aPreviousMonthModel.monthsYear.components(separatedBy: "-")[1])
        let aSelectedMonthYear = String.init(format: "%@ %@", GetMonthNameFromNumber(aStrMonthValue!) , aStrYearValue)
        
        aPreviousMonthCell.lblMonthTitle.text = aSelectedMonthYear
        
        var aTotalIncome = aPreviousMonthModel.totalIncome
        if aTotalIncome == nil {
            aTotalIncome = 0
        }
        
        var aTotalIncomeRecurring = aPreviousMonthModel.totalIncomeRecurring
        if aTotalIncomeRecurring == nil {
            aTotalIncomeRecurring =  0
        }
        
        var aTotalSpending = aPreviousMonthModel.totalSpending
        if aTotalSpending == nil {
            aTotalSpending =  0
        }
        
        var aTotalSpendingRecurring = aPreviousMonthModel.totalSpendingRecurring
        
        if aTotalSpendingRecurring == nil {
            aTotalSpendingRecurring = 0
        }
        
        let aTotalIncomeValue = Float((aTotalIncome!) + (aTotalIncomeRecurring!))
        
        let aTotalSpendingValue = ((aTotalSpending)! + (aTotalSpendingRecurring)!)
        
        let aTotalSavingValue = Float(aPreviousMonthModel.totalSaving)
        
        aPreviousMonthCell.lblMonthIncomeValue.text = String(aTotalIncomeValue)
        aPreviousMonthCell.lblMonthSpendingValue.text = String(aTotalSpendingValue)
        aPreviousMonthCell.lblMonthSavingValue.text = String(aTotalSavingValue)
        aPreviousMonthCell.lblMonthRemainingValue.text = String(aTotalIncomeValue - (aTotalSpendingValue + aTotalSavingValue))
        
        Utility.sharedInstance.customizeFonts(in: aPreviousMonthCell.lblMonthIncomeValue, aFontName: SemiBold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aPreviousMonthCell.lblMonthTitle, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aPreviousMonthCell.lblMonthSpendingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aPreviousMonthCell.lblMonthSavingValue, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: aPreviousMonthCell.lblMonthRemainingValue, aFontName: Medium, aFontSize: 0)
        
        
        aPreviousMonthCell.lblMonthSpendingColour.layer.masksToBounds = true
        aPreviousMonthCell.lblMonthSpendingColour.layer.cornerRadius = 6
        aPreviousMonthCell.lblMonthSpendingColour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
        
        aPreviousMonthCell.lblMonthSavingColour.layer.masksToBounds = true
        aPreviousMonthCell.lblMonthSavingColour.layer.cornerRadius = 6
        aPreviousMonthCell.lblMonthSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        aPreviousMonthCell.lblMonthRemainingColour.layer.masksToBounds = true
        aPreviousMonthCell.lblMonthRemainingColour.layer.cornerRadius = 6
        aPreviousMonthCell.lblMonthRemainingColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        
        aPreviousMonthCell.viewMonthPieChart.drawSlicesUnderHoleEnabled = true
        aPreviousMonthCell.viewMonthPieChart.drawCenterTextEnabled = true
        aPreviousMonthCell.viewMonthPieChart.drawEntryLabelsEnabled = true
        aPreviousMonthCell.viewMonthPieChart.highlightPerTapEnabled = false
        aPreviousMonthCell.viewMonthPieChart.chartDescription?.text = ""
        aPreviousMonthCell.viewMonthPieChart.holeRadiusPercent = 0.4
        aPreviousMonthCell.viewMonthPieChart.legend.enabled = false
        aPreviousMonthCell.viewMonthPieChart.noDataText = ""
        
        if aTotalIncomeValue > 0 {
            var aPercentVal = Float(Float(aTotalSpendingValue * 100) / Float(aTotalIncomeValue))
            if aPercentVal > 100 {
                aPercentVal = 100
            }
            
//            aPreviousMonthCell.viewMonthPieChart.centerText = String.init(format: "%.1f %@", aPercentVal,"%")
            
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
            aPreviousMonthCell.viewMonthPieChart.centerAttributedText = myAttrString

            
            
            
            let aViewSavingCalculation = [Double(aTotalSpendingValue),Double(aTotalSavingValue),Double(aTotalIncomeValue - aTotalSpendingValue)]
            
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
            
            aPreviousMonthCell.viewMonthPieChart.data = pieChartData
            
            pieChartDataSet.colors = aColors

        }
        
        
        return aPreviousMonthCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let objPreviousMonthDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviousMonthDetailVC") as! PreviousMonthDetailVC
        
        let aPreviousMonthModel = arrPreviousMonthNewData[indexPath.row] as PreviousMonthModel
        
        let aStrYearValue = aPreviousMonthModel.monthsYear.components(separatedBy: "-")[0]
        let aStrMonthValue = aPreviousMonthModel.monthsYear.components(separatedBy: "-")[1]
        objPreviousMonthDetailVC.aSelectedMonthValue = String(aStrMonthValue)
        objPreviousMonthDetailVC.aSelectedYearValue = String(aStrYearValue)
        
        self.navigationController?.pushViewController(objPreviousMonthDetailVC, animated: true)
        
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
