//
//  PreviousMonthDetailVC.swift
//  Edkhar
//
//  Created by indianic on 15/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD
import Charts

class PreviousMonthDetailVC: UIViewController {
    
    
    var aSelectedMonthValue = String()
    var aSelectedYearValue = String()
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    
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
    @IBOutlet weak var viewPTargetSavingPieChart: PieChartView!
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
    //-- View Av. Of Spending Weekly - monthly Options -- //
    
    
    
    
    var aPTotalIncomeValue : Int = 0
    var aPTotalSpendingValue : Int = 0
    var aPTotalSavingValue : Int = 0
    
    
    var arrPTargetList = [TargetModel]()
    var arrPSavingList = [SavingModel]()
    
    @IBOutlet weak var lblNoSavingGraph: UILabel!
    @IBOutlet weak var lblNoMostSpendingGraph: UILabel!
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        
        let aStrMonthValue = Int(aSelectedMonthValue)
        let aSelectedMonthYear = String.init(format: "%@ %d", GetMonthNameFromNumber(aStrMonthValue!) , Int(aSelectedYearValue)!)
        
        
        DispatchQueue.main.async {
            Utility.sharedInstance.customizeFonts(in: self.lblScreenTitle, aFontName: Medium, aFontSize: 0)
            
            self.lblScreenTitle.text = aSelectedMonthYear
        }
        
        
        print("aSelectedMonthValue = \(aSelectedMonthValue)")
        
        
        print("aSelectedYearValue = \(aSelectedYearValue)")
        
        
        
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
        
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
        }
        else{
            btnBackAR.isHidden = true
        }
        
        self.setExpenseChartData()
        
        // Do any additional setup after loading the view.
        
        
        viewPExpensesPieChart.drawSlicesUnderHoleEnabled = true
        viewPExpensesPieChart.drawCenterTextEnabled = true
        viewPExpensesPieChart.drawEntryLabelsEnabled = true
        viewPExpensesPieChart.highlightPerTapEnabled = false
        viewPExpensesPieChart.chartDescription?.text = ""
        viewPExpensesPieChart.holeRadiusPercent = 0.4
        viewPExpensesPieChart.legend.enabled = false
        viewPExpensesPieChart.noDataText = ""
        
        viewPTargetSavingPieChart.drawSlicesUnderHoleEnabled = true
        viewPTargetSavingPieChart.drawCenterTextEnabled = true
        viewPTargetSavingPieChart.drawEntryLabelsEnabled = true
        viewPTargetSavingPieChart.highlightPerTapEnabled = false
        viewPTargetSavingPieChart.chartDescription?.text = ""
        viewPTargetSavingPieChart.holeRadiusPercent = 0.4
        viewPTargetSavingPieChart.legend.enabled = false
//        viewPTargetSavingPieChart.drawHoleEnabled = false
        
        viewPMostSpendingPieChart.drawSlicesUnderHoleEnabled = true
        viewPMostSpendingPieChart.drawCenterTextEnabled = false
        viewPMostSpendingPieChart.drawEntryLabelsEnabled = true
        viewPMostSpendingPieChart.highlightPerTapEnabled = false
        viewPMostSpendingPieChart.chartDescription?.text = ""
        viewPMostSpendingPieChart.holeRadiusPercent = 0
        viewPMostSpendingPieChart.drawHoleEnabled = false
        viewPMostSpendingPieChart.legend.enabled = false
        viewPMostSpendingPieChart.usePercentValuesEnabled = false
         viewPMostSpendingPieChart.noDataText =  JMOLocalizedString(forKey: "You did not enter any spending yet!", value: "")
        
        viewPSpendingOptionPieChart.drawSlicesUnderHoleEnabled = true
        viewPSpendingOptionPieChart.drawCenterTextEnabled = true
        viewPSpendingOptionPieChart.drawEntryLabelsEnabled = true
        viewPSpendingOptionPieChart.highlightPerTapEnabled = false
        viewPSpendingOptionPieChart.chartDescription?.text = ""
        viewPSpendingOptionPieChart.holeRadiusPercent = 0.4
        viewPSpendingOptionPieChart.legend.enabled = false
        viewPSpendingOptionPieChart.noDataText =  JMOLocalizedString(forKey: "You did not enter any spending yet!", value: "")
//        viewPSpendingOptionPieChart.drawHoleEnabled = false
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func setExpenseChartData() -> Void {
        
        let arrMutMonthlyExpenseList = userInfoManagerT.sharedInstance.GetPreviousMonthExpenseList(aMonth: aSelectedMonthValue, aYear: aSelectedYearValue)
        
        if arrMutMonthlyExpenseList.count > 0 {
            
            let aTotalSpendingValue = arrMutMonthlyExpenseList.first?.spending_value!
            let aTotalIncomeValue = arrMutMonthlyExpenseList.first?.income_value!
            let aTotalSavingValue = arrMutMonthlyExpenseList.first?.saving_value!
//            let aTotalRemainingValue = arrMutMonthlyExpenseList.first?.remainingIncome!
            let aTotalRemainingValue = (aTotalIncomeValue! - (aTotalSpendingValue! + aTotalSavingValue!))
            
            print("aTotalSpendingValue = \(aTotalSpendingValue!)")
            print("aTotalIncomeValue = \(aTotalIncomeValue!)")
            print("aTotalSavingValue = \(aTotalSavingValue!)")
            print("aTotalRemainingValue = \(aTotalRemainingValue)")
            
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
            
            
            // Total expense view calculation//
            
            self.lblPExpIncomeValue.text = String(aTotalIncomeValue!)
            self.lblPExpSpendingValue.text = String(aTotalSpendingValue!)
            self.lblPExpSavingValue.text = String(aTotalSavingValue!)
            self.lblPExpRemainingValue.text = String(aTotalRemainingValue)
            
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
//                viewPExpensesPieChart.centerText = String.init(format: "%.1f %@", aPercentVal,"%")
                
                
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
                viewPExpensesPieChart.centerAttributedText = myAttrString
                
                
                self.SetViewExpensesPieChart(values: aViewSavingCalculation, colours: aColors)

            }
            
            
            
            // Total expense view calculation //
            
            
            // Daily and weekly expense //
//            let aWeeklySpendingValue = (Float(Float(aTotalSpendingValue!) / Float(Utility.sharedInstance.getNumberOfDaysInMonth(month: Int(aStrSelectedMonth)!, year: Int(aStrSelectedYear)!)))) / 7
//            let aDailySpendingValue = (Float(Float(aTotalSpendingValue!) / Float(Utility.sharedInstance.getNumberOfDaysInMonth(month: Int(aStrSelectedMonth)!, year: Int(aStrSelectedYear)!))))
            
            
            let aWeeklySpendingValue = Float(Float(aTotalSpendingValue!) / Float(Utility.sharedInstance.getWeekFromTodayDate()))
            let aDailySpendingValue = Float(Float(aTotalSpendingValue!) / Float(Utility.sharedInstance.getDayFromTodayDate()))
            
            
            print("Weekly Spending = \(String(format: "%.2f", aWeeklySpendingValue))")
            print("Daily Spending = \(String(format: "%.2f", aDailySpendingValue))")
            
            self.lblPMostSpendingWeeklyValue.text = String(format: "%.2f", aWeeklySpendingValue)
            self.lblPMostSpendingDailyValue.text = String(format: "%.2f", aDailySpendingValue)
            
            // Daily and weekly expense //
            
        }
        
        
        // == Saving list chart details == //
        
        // Saving List
        let aMutArrPreviousYearSavingList = userInfoManagerT.sharedInstance.GetPreviousMonthSavingList(aMonth: aSelectedMonthValue, aYear: aSelectedYearValue)
        
        
        lblNoSavingGraph.isHidden = true
        viewPTargetSavingPieChart.isHidden = false
        if aMutArrPreviousYearSavingList.count > 0 {
            print("target_id = \(aMutArrPreviousYearSavingList.first?.target_id!)")
            print("target_name = \(aMutArrPreviousYearSavingList.first?.target_name!)")
            print("target_final_amount = \(aMutArrPreviousYearSavingList.first?.target_final_amount!)")
            print("target_saved_amount = \(aMutArrPreviousYearSavingList.first?.target_saved_amount!)")
            print("target_final_date = \(aMutArrPreviousYearSavingList.first?.target_final_date!)")
            print("target_monthly_installment = \(aMutArrPreviousYearSavingList.first?.target_monthly_installment!)")
            print("target_total_saving_value = \(aMutArrPreviousYearSavingList.first?.target_total_saving_value!)")
            
            if aMutArrPreviousYearSavingList.count == 1 {
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                
                lblPSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblPSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblPSavingList2.isHidden = true
                lblPSavingList2Colour.isHidden = true
                lblPSavingList2Value.isHidden = true
                
                
                lblPSavingList3.isHidden = true
                lblPSavingList3Colour.isHidden = true
                lblPSavingList3Value.isHidden = true
                
                
                lblPSavingOthers.isHidden = true
                lblPSavingOthersColour.isHidden = true
                lblPSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                let aPTotalSavingValue = (aSaving1Value)
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                
                let aViewSavingCalculation = [Double(aSaving1Per)]
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue)]
                
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
                
            }
            else if aMutArrPreviousYearSavingList.count == 2 {
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                lblPSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblPSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblPSavingList2.isHidden = false
                lblPSavingList2Colour.isHidden = false
                lblPSavingList2Value.isHidden = false
                lblPSavingList2.text = aMutArrPreviousYearSavingList[1].target_name!
                lblPSavingList2Value.text = String(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                lblPSavingList3.isHidden = true
                lblPSavingList3Colour.isHidden = true
                lblPSavingList3Value.isHidden = true
                
                lblPSavingOthers.isHidden = true
                lblPSavingOthersColour.isHidden = true
                lblPSavingOthersValue.isHidden = true
                
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
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                lblPSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblPSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblPSavingList2.isHidden = false
                lblPSavingList2Colour.isHidden = false
                lblPSavingList2Value.isHidden = false
                lblPSavingList2.text = aMutArrPreviousYearSavingList[1].target_name!
                lblPSavingList2Value.text = String(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                lblPSavingList3.isHidden = false
                lblPSavingList3Colour.isHidden = false
                lblPSavingList3Value.isHidden = false
                lblPSavingList3.text = aMutArrPreviousYearSavingList[2].target_name!
                lblPSavingList3Value.text = String(aMutArrPreviousYearSavingList[2].target_total_saving_value!)
                
                lblPSavingOthers.isHidden = true
                lblPSavingOthersColour.isHidden = true
                lblPSavingOthersValue.isHidden = true
                
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
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                lblPSavingList1.text = aMutArrPreviousYearSavingList[0].target_name!
                lblPSavingList1Value.text = String(aMutArrPreviousYearSavingList[0].target_total_saving_value!)
                
                lblPSavingList2.isHidden = false
                lblPSavingList2Colour.isHidden = false
                lblPSavingList2Value.isHidden = false
                lblPSavingList2.text = aMutArrPreviousYearSavingList[1].target_name!
                lblPSavingList2Value.text = String(aMutArrPreviousYearSavingList[1].target_total_saving_value!)
                
                
                lblPSavingList3.isHidden = false
                lblPSavingList3Colour.isHidden = false
                lblPSavingList3Value.isHidden = false
                lblPSavingList3.text = aMutArrPreviousYearSavingList[2].target_name!
                lblPSavingList3Value.text = String(aMutArrPreviousYearSavingList[2].target_total_saving_value!)
                
                lblPSavingOthers.isHidden = false
                lblPSavingOthersColour.isHidden = false
                lblPSavingOthersValue.isHidden = false
                
                lblPSavingOthers.text = JMOLocalizedString(forKey: "Other:", value: "")
                var aTotalOtherValue = Int()
                for i in 3...(aMutArrPreviousYearSavingList.count - 1){
                    aTotalOtherValue = aTotalOtherValue + Int(aMutArrPreviousYearSavingList[i].target_total_saving_value!)
                }
                lblPSavingOthersValue.text = String(aTotalOtherValue)
                
                
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
            
            lblPSavingList1Colour.layer.masksToBounds = true
            lblPSavingList1Colour.layer.cornerRadius = 6
            lblPSavingList1Colour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
            
            lblPSavingList2Colour.layer.masksToBounds = true
            lblPSavingList2Colour.layer.cornerRadius = 6
            lblPSavingList2Colour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
            
            lblPSavingList3Colour.layer.masksToBounds = true
            lblPSavingList3Colour.layer.cornerRadius = 6
            lblPSavingList3Colour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
            
            lblPSavingOthersColour.layer.masksToBounds = true
            lblPSavingOthersColour.layer.cornerRadius = 6
            lblPSavingOthersColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
            
            
        }
        else{
            lblPSavingList1.isHidden = true
            lblPSavingList1Colour.isHidden = true
            lblPSavingList1Value.isHidden = true
            
            lblPSavingList2.isHidden = true
            lblPSavingList2Colour.isHidden = true
            lblPSavingList2Value.isHidden = true
            
            lblPSavingList3.isHidden = true
            lblPSavingList3Colour.isHidden = true
            lblPSavingList3Value.isHidden = true
            
            lblPSavingOthers.isHidden = true
            lblPSavingOthersColour.isHidden = true
            lblPSavingOthersValue.isHidden = true
            
            
            lblNoSavingGraph.isHidden = false
            viewPTargetSavingPieChart.isHidden = true
            
        }
        
        // == Saving list chart details == //
        
        
        
        
        
        
        // = most spending category chart details  == //
        
        // Most Spending Category
        let aMutArrPreviousYearMostSpendingCategory = userInfoManagerT.sharedInstance.GetPreviousMonthMostSpendingCategoryList(aMonth: aSelectedMonthValue, aYear: aSelectedYearValue)
        lblNoMostSpendingGraph.isHidden = true
        viewPMostSpendingPieChart.isHidden = false
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
                        }
                        else{
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
        
        // = most spending category chart details  == //
        
        
        
        
        
        
        
        // = most spending options chart details  == //
        
        var arrSpendingList = [SpendingModel]()
        
        arrSpendingList = userInfoManagerT.sharedInstance.GetAllSpendingListByProvidedMonthYear(aSelectedMonth: aSelectedMonthValue, aSelectedYear: aSelectedYearValue)
        
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
        
        
        // = most spending options chart details  == //
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
        
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
        
        viewPTargetSavingPieChart.data = pieChartData
        
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

    
   /* func ViewExpensesCalculation() -> Void {
        
        SVProgressHUD.show()
        
        self.GetTotalIncomeDetails()
        self.GetTotalSpendingDetails()
        self.GetTotalSavingDetails()
        
        
        lblPExpSpendingColour.layer.masksToBounds = true
        lblPExpSpendingColour.layer.cornerRadius = 6
        lblPExpSpendingColour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
        
        lblPExpSavingColour.layer.masksToBounds = true
        lblPExpSavingColour.layer.cornerRadius = 6
        lblPExpSavingColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
        
        lblPExpRemainingColour.layer.masksToBounds = true
        lblPExpRemainingColour.layer.cornerRadius = 6
        lblPExpRemainingColour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
    } */
    
 /*   func getTargetSavingFromSavingTable(_ targetID : Int) -> Int {
        
        var savingByTargetID = 0
        let arrFilterSavingbyID  = self.arrPSavingList.filter { (objSavingModel : SavingModel) -> Bool in
            return objSavingModel.target_id == targetID
        }
        if arrFilterSavingbyID.count > 0 {
            for aDictSaving in arrFilterSavingbyID{
                savingByTargetID = savingByTargetID + Int((aDictSaving.saving_value!))!
            }
        }
        
       

        
        return savingByTargetID
    } */

    
/*    func ViewSavingCalculation() -> Void {
        
        SVProgressHUD.show()
        
        self.arrPTargetList = userInfoManager.sharedInstance.GetAllTargetListTitle()
        
        self.arrPSavingList = userInfoManager.sharedInstance.GetAllSavingListTitle()
        
        var aTargetSavinglist = [[String:String]]()
        
        if self.arrPTargetList.count > 0{
            
            for i in 0...(self.arrPTargetList.count - 1){
                let aTargetSavedAmount = Int(self.arrPTargetList[i].target_saved_amount!)
                let aSavingValueFromTargetID = self.getTargetSavingFromSavingTable(self.arrPTargetList[i].identifier)
                let aTotalTargetSaving = (aTargetSavedAmount! + aSavingValueFromTargetID)
                
                let aDicTargetSaving : [String: String] = ["target_name":self.arrPTargetList[i].target_name,"target_total_saving":String(aTotalTargetSaving)]
                aTargetSavinglist.append(aDicTargetSaving)
                
            }
            
            let aTargetSavingFilterlist = aTargetSavinglist.sorted { (p1: [String : String], p2: [String : String]) -> Bool in
                return Int(p1["target_total_saving"]!)! > Int(p2["target_total_saving"]!)!
                
            }
            
            
            if aTargetSavingFilterlist.count == 1 {
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                
                lblPSavingList1.text = aTargetSavingFilterlist[0]["target_name"]!
                lblPSavingList1Value.text = aTargetSavingFilterlist[0]["target_total_saving"]!
                
                lblPSavingList2.isHidden = true
                lblPSavingList2Colour.isHidden = true
                lblPSavingList2Value.isHidden = true
                
                
                lblPSavingList3.isHidden = true
                lblPSavingList3Colour.isHidden = true
                lblPSavingList3Value.isHidden = true
                
                
                lblPSavingOthers.isHidden = true
                lblPSavingOthersColour.isHidden = true
                lblPSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aTargetSavingFilterlist[0]["target_total_saving"]!)!
                let aPTotalSavingValue = (aSaving1Value)
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                
                let aViewSavingCalculation = [Double(aSaving1Per)]

                let aColors = [UIColor(hex: GraphColour.kYello.rawValue)]
                
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
                
            }
            else if aTargetSavingFilterlist.count == 2 {
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                lblPSavingList1.text = aTargetSavingFilterlist[0]["target_name"]!
                lblPSavingList1Value.text = aTargetSavingFilterlist[0]["target_total_saving"]!
                
                lblPSavingList2.isHidden = false
                lblPSavingList2Colour.isHidden = false
                lblPSavingList2Value.isHidden = false
                lblPSavingList2.text = aTargetSavingFilterlist[0]["target_name"]!
                lblPSavingList2Value.text = aTargetSavingFilterlist[1]["target_total_saving"]!
                
                
                lblPSavingList3.isHidden = true
                lblPSavingList3Colour.isHidden = true
                lblPSavingList3Value.isHidden = true
                
                lblPSavingOthers.isHidden = true
                lblPSavingOthersColour.isHidden = true
                lblPSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aTargetSavingFilterlist[0]["target_total_saving"]!)!
                let aSaving2Value = Int(aTargetSavingFilterlist[1]["target_total_saving"]!)!
                
                
                let aPTotalSavingValue = (aSaving1Value + aSaving2Value)
                
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                let aSaving2Per = Double(Float(aSaving2Value) / Float(aPTotalSavingValue) * 100)
                
                
                
                let aViewSavingCalculation = [Double(aSaving1Per),Double(aSaving2Per)]
                
                
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
                
            }
            else if aTargetSavingFilterlist.count == 3 {
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                lblPSavingList1.text = aTargetSavingFilterlist[0]["target_name"]!
                lblPSavingList1Value.text = aTargetSavingFilterlist[0]["target_total_saving"]!
                
                lblPSavingList2.isHidden = false
                lblPSavingList2Colour.isHidden = false
                lblPSavingList2Value.isHidden = false
                lblPSavingList2.text = aTargetSavingFilterlist[1]["target_name"]!
                lblPSavingList2Value.text = aTargetSavingFilterlist[1]["target_total_saving"]!
                
                
                lblPSavingList3.isHidden = false
                lblPSavingList3Colour.isHidden = false
                lblPSavingList3Value.isHidden = false
                lblPSavingList3.text = aTargetSavingFilterlist[2]["target_name"]!
                lblPSavingList3Value.text = aTargetSavingFilterlist[2]["target_total_saving"]!
                
                lblPSavingOthers.isHidden = true
                lblPSavingOthersColour.isHidden = true
                lblPSavingOthersValue.isHidden = true
                
                let aSaving1Value = Int(aTargetSavingFilterlist[0]["target_total_saving"]!)!
                let aSaving2Value = Int(aTargetSavingFilterlist[1]["target_total_saving"]!)!
                let aSaving3Value = Int(aTargetSavingFilterlist[2]["target_total_saving"]!)!
                
                let aPTotalSavingValue = (aSaving1Value + aSaving2Value + aSaving3Value)
                
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                let aSaving2Per = Double(Float(aSaving2Value) / Float(aPTotalSavingValue) * 100)
                let aSaving3Per = Double(Float(aSaving3Value) / Float(aPTotalSavingValue) * 100)
                
                
                let aViewSavingCalculation = [Double(aSaving1Per),Double(aSaving2Per),Double(aSaving3Per)]
                
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kOrange.rawValue)]
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
            }
            else if aTargetSavingFilterlist.count >= 4 {
                
                lblPSavingList1.isHidden = false
                lblPSavingList1Colour.isHidden = false
                lblPSavingList1Value.isHidden = false
                lblPSavingList1.text = aTargetSavingFilterlist[0]["target_name"]!
                lblPSavingList1Value.text = aTargetSavingFilterlist[0]["target_total_saving"]!
                
                lblPSavingList2.isHidden = false
                lblPSavingList2Colour.isHidden = false
                lblPSavingList2Value.isHidden = false
                lblPSavingList2.text = aTargetSavingFilterlist[1]["target_name"]!
                lblPSavingList2Value.text = aTargetSavingFilterlist[1]["target_total_saving"]!
                
                
                lblPSavingList3.isHidden = false
                lblPSavingList3Colour.isHidden = false
                lblPSavingList3Value.isHidden = false
                lblPSavingList3.text = aTargetSavingFilterlist[2]["target_name"]!
                lblPSavingList3Value.text = aTargetSavingFilterlist[2]["target_total_saving"]!
                
                lblPSavingOthers.isHidden = false
                lblPSavingOthersColour.isHidden = false
                lblPSavingOthersValue.isHidden = false
                
                lblPSavingOthers.text = JMOLocalizedString(forKey: "Other:", value: "")
                var aTotalOtherValue = Int()
                for i in 3...(aTargetSavingFilterlist.count - 1){
                    aTotalOtherValue = aTotalOtherValue + Int(aTargetSavingFilterlist[i]["target_total_saving"]!)!
                }
                lblPSavingOthersValue.text = String(aTotalOtherValue)
                
                
                let aSaving1Value = Int(aTargetSavingFilterlist[0]["target_total_saving"]!)!
                let aSaving2Value = Int(aTargetSavingFilterlist[1]["target_total_saving"]!)!
                let aSaving3Value = Int(aTargetSavingFilterlist[2]["target_total_saving"]!)!
                let aSavingOtherValue = Int(aTargetSavingFilterlist[3]["target_total_saving"]!)!
                
                let aPTotalSavingValue = (aSaving1Value + aSaving2Value + aSaving3Value + aSavingOtherValue)
                
                let aSaving1Per = Double(Float(aSaving1Value) / Float(aPTotalSavingValue) * 100)
                let aSaving2Per = Double(Float(aSaving2Value) / Float(aPTotalSavingValue) * 100)
                let aSaving3Per = Double(Float(aSaving3Value) / Float(aPTotalSavingValue) * 100)
                let aSavingOtherPer = Double(Float(aSavingOtherValue) / Float(aPTotalSavingValue) * 100)
                
                let aViewSavingCalculation = [Double(aSaving1Per),Double(aSaving2Per),Double(aSaving3Per),Double(aSavingOtherPer)]
                
                let aColors = [UIColor(hex: GraphColour.kYello.rawValue),UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kBlue.rawValue)]
                
                self.SetViewTargetSavingPieChart(values: aViewSavingCalculation, colours: aColors)
            }
            
            lblPSavingList1Colour.layer.masksToBounds = true
            lblPSavingList1Colour.layer.cornerRadius = 6
            lblPSavingList1Colour.backgroundColor = UIColor(hex: GraphColour.kYello.rawValue)
            
            lblPSavingList2Colour.layer.masksToBounds = true
            lblPSavingList2Colour.layer.cornerRadius = 6
            lblPSavingList2Colour.backgroundColor = UIColor(hex: GraphColour.kGreen.rawValue)
            
            lblPSavingList3Colour.layer.masksToBounds = true
            lblPSavingList3Colour.layer.cornerRadius = 6
            lblPSavingList3Colour.backgroundColor = UIColor(hex: GraphColour.kOrange.rawValue)
            
            lblPSavingOthersColour.layer.masksToBounds = true
            lblPSavingOthersColour.layer.cornerRadius = 6
            lblPSavingOthersColour.backgroundColor = UIColor(hex: GraphColour.kBlue.rawValue)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SVProgressHUD.dismiss()
            }
        }
        
        
    } */
    
   /* func GetTotalIncomeDetails() -> Void {
        var arrIncomeList = [IncomeModel]()
        arrIncomeList = userInfoManager.sharedInstance.GetAllIncomeList()
        
        // Calculate for Total income.
        
        if arrIncomeList.count > 0 {
            for i in 0...(arrIncomeList.count - 1){
                let aIncomeModel = arrIncomeList[i]
                aPTotalIncomeValue += Int(aIncomeModel.income_value as String!)!
            }
        }
        
        self.lblPExpIncomeValue.text = String(aPTotalIncomeValue)
        
    } */
    
    
  /*  func getSpendingTypeTitleFromSpendingID(_ SpendingTypeID : Int, objSpendingTypeModelList : [SpendingTypeModel]) -> String {
        
        var aStrSpendingTypeTitle = ""
        
        let arrFilterSpendingTypeList  = objSpendingTypeModelList.filter { (objSpendingTypeModel : SpendingTypeModel) -> Bool in
            return objSpendingTypeModel.spending_type_id == SpendingTypeID
        }
        
        
        if arrFilterSpendingTypeList.count > 0 {
            
            if AppConstants.isArabic() {
                aStrSpendingTypeTitle = (arrFilterSpendingTypeList.first?.spending_type_title_ar!)!
            }else{
                aStrSpendingTypeTitle = (arrFilterSpendingTypeList.first?.spending_type_title!)!
            }
        }
        return aStrSpendingTypeTitle
    } */
    
  /*  func GetTotalSpendingDetails() -> Void {
        
        var arrSpendingList = [SpendingModel]()
        
        arrSpendingList = userInfoManager.sharedInstance.GetAllSpendingList()
        
        
        // Calculate for Total income.
        
        if arrSpendingList.count > 0 {
            for i in 0...(arrSpendingList.count - 1){
                let aSpendingModel = arrSpendingList[i]
                aPTotalSpendingValue += Int(aSpendingModel.spending_value as String!)!
            }
        }
        
        self.lblPExpSpendingValue.text = String(aPTotalSpendingValue)
        
        self.lblPExpRemainingValue.text = String(aPTotalIncomeValue - aPTotalSpendingValue)
        
        let aWeeklySpendingValue = (Float(Float(aPTotalSpendingValue) / 30)) / 7
        let aDailySpendingValue = (Float(Float(aPTotalSpendingValue) / 30))
        
        self.lblPMostSpendingWeeklyValue.text = String(format: "%.2f", aWeeklySpendingValue)
        self.lblPMostSpendingDailyValue.text = String(format: "%.2f", aDailySpendingValue)
        
        //--- Handle the graph for most spending category basis --- //
        
        if arrSpendingList.count > 0{
            
          let aSpendingCateFilterlist = arrSpendingList.sorted(by: { (objSpendingModel1, objSpendingModel2) -> Bool in
                return objSpendingModel1.spending_value > objSpendingModel2.spending_value
            })
            
            let arrSpendingCategoryTitelList : [SpendingTypeModel] = userInfoManager.sharedInstance.GetAllSpendingListTitle()
            
            if aSpendingCateFilterlist.count == 1 {
                
                let aSpendingCate1Value = Int(aSpendingCateFilterlist[0].spending_value)!
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue)]
                
                var aaSpendingCateTitles = String()
                
                if arrSpendingCategoryTitelList.count > 0 {
                    
                    aaSpendingCateTitles = self.getSpendingTypeTitleFromSpendingID(aSpendingCateFilterlist[0].spending_type_id, objSpendingTypeModelList: arrSpendingCategoryTitelList)
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors, spendingTypeTitleList: [aaSpendingCateTitles])
                
            }
            else if aSpendingCateFilterlist.count == 2 {
                
                let aSpendingCate1Value = Int(aSpendingCateFilterlist[0].spending_value)!
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aPTotalSpendingValue))
                
                let aSpendingCate2Value = Int(aSpendingCateFilterlist[1].spending_value)!
                let aSpending2Per = Double(Float(aSpendingCate2Value * 100) / Float(aPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per),Double(aSpending2Per)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kBlue.rawValue)]
                
                
                var aaSpendingCateTitleslist = [String]()
                
                if arrSpendingCategoryTitelList.count > 0 {
                    
                    for i in 0...(aSpendingCateFilterlist.count - 1){
                       let aaSpendingCateTitles = self.getSpendingTypeTitleFromSpendingID(aSpendingCateFilterlist[i].spending_type_id, objSpendingTypeModelList: arrSpendingCategoryTitelList)
                        
                        aaSpendingCateTitleslist.append(aaSpendingCateTitles)
                    }
                }
                
               self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors,spendingTypeTitleList:aaSpendingCateTitleslist)
                
            }
            else if aSpendingCateFilterlist.count == 3 {
                
                let aSpendingCate1Value = Int(aSpendingCateFilterlist[0].spending_value)!
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aPTotalSpendingValue))
                
                let aSpendingCate2Value = Int(aSpendingCateFilterlist[1].spending_value)!
                let aSpending2Per = Double(Float(aSpendingCate2Value * 100) / Float(aPTotalSpendingValue))
                
                let aSpendingCate3Value = Int(aSpendingCateFilterlist[2].spending_value)!
                let aSpending3Per = Double(Float(aSpendingCate3Value * 100) / Float(aPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per),Double(aSpending2Per),Double(aSpending3Per)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kOrange.rawValue)]
                
                var aaSpendingCateTitleslist = [String]()
                
                if arrSpendingCategoryTitelList.count > 0 {
                    
                    for i in 0...(arrSpendingCategoryTitelList.count - 1){
                        let aaSpendingCateTitles = self.getSpendingTypeTitleFromSpendingID(aSpendingCateFilterlist[i].spending_type_id, objSpendingTypeModelList: arrSpendingCategoryTitelList)
                        
                        aaSpendingCateTitleslist.append(aaSpendingCateTitles)
                    }
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors,spendingTypeTitleList:aaSpendingCateTitleslist)

            }
            else if aSpendingCateFilterlist.count >= 4 {
                
                let aSpendingCate1Value = Int(aSpendingCateFilterlist[0].spending_value)!
                let aSpending1Per = Double(Float(aSpendingCate1Value * 100) / Float(aPTotalSpendingValue))
                
                let aSpendingCate2Value = Int(aSpendingCateFilterlist[1].spending_value)!
                let aSpending2Per = Double(Float(aSpendingCate2Value * 100) / Float(aPTotalSpendingValue))
                
                let aSpendingCate3Value = Int(aSpendingCateFilterlist[2].spending_value)!
                let aSpending3Per = Double(Float(aSpendingCate3Value * 100) / Float(aPTotalSpendingValue))
                
                let aSpendingCateOtherValue = Int(aSpendingCateFilterlist[3].spending_value)!
                let aSpendingOtherPer = Double(Float(aSpendingCateOtherValue * 100) / Float(aPTotalSpendingValue))
                
                let aViewSpendingCateCalculation = [Double(aSpending1Per),Double(aSpending2Per),Double(aSpending3Per),Double(aSpendingOtherPer)]
                
                let aColors = [UIColor(hex: GraphColour.kGreen.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kYello.rawValue)]
                
                
                var aaSpendingCateTitleslist = [String]()
                
                if arrSpendingCategoryTitelList.count > 0 {
                    
                    for i in 0...2{
                        let aaSpendingCateTitles = self.getSpendingTypeTitleFromSpendingID(aSpendingCateFilterlist[i].spending_type_id, objSpendingTypeModelList: arrSpendingCategoryTitelList)
                        
                        aaSpendingCateTitleslist.append(aaSpendingCateTitles)
                    }
                    aaSpendingCateTitleslist.append(JMOLocalizedString(forKey: "Others", value: ""))
                }
                
                self.SetViewMostExpensesCategoryPieChart(values: aViewSpendingCateCalculation, colours: aColors,spendingTypeTitleList:aaSpendingCateTitleslist)
                
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SVProgressHUD.dismiss()
            }
            
        }
        
        
        //--- Handle the graph for most spending category basis --- //
        
        
        
        //--- Handle the graph for spending Options basis --- //
        
//        @IBOutlet weak var lblPSpendingOptLuxuryValue: UILabel!
//        
//        @IBOutlet weak var lblPSpendingOptNecessaryValue: UILabel!
//        
//        @IBOutlet weak var lblPSpendingOptNotDefinedValue: UILabel!

        if arrSpendingList.count > 0{
            
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
                        aTotalSpendingOptionLuxury += Double(objSpendingModel.spending_value as String!)!
                    }
                }
        
                print("aTotalSpendingOptionLuxury = \(aTotalSpendingOptionLuxury)")
                
                lblPSpendingOptLuxuryValue.text = String(aTotalSpendingOptionLuxury)
                
                let aSpendingOptionLuxuryPer = Double(Float(aTotalSpendingOptionLuxury * 100) / Float(aPTotalSpendingValue))
                
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
                        aTotalSpendingOptionNecessary += Double(objSpendingModel.spending_value as String!)!
                    }
                }
                
                print("aTotalSpendingOptionNecessary = \(aTotalSpendingOptionNecessary)")
                
                lblPSpendingOptNecessaryValue.text = String(aTotalSpendingOptionNecessary)
                
                let aSpendingOptionNecessaryPer = Double(Float(aTotalSpendingOptionNecessary * 100) / Float(aPTotalSpendingValue))
                
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
                        aTotalSpendingOptionNotDefined += Double(objSpendingModel.spending_value as String!)!
                    }
                }
                
                print("aTotalSpendingOptionNotDefined = \(aTotalSpendingOptionNotDefined)")
                
                 lblPSpendingOptNotDefinedValue.text = String(aTotalSpendingOptionNotDefined)
                
                let aSpendingOptionNotDefinedPer = Double(Float(aTotalSpendingOptionNotDefined * 100) / Float(aPTotalSpendingValue))
                
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
        
        
        
        //--- Handle the graph for spending Options basis --- //
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }

        
    } */
    
 /*   func GetTotalSavingDetails() -> [SavingModel] {
        
        var arrPSavingList = [SavingModel]()
        
        arrPSavingList = userInfoManager.sharedInstance.GetAllSavingListTitle()
        
        // Calculate for Total income.
        
        if arrPSavingList.count > 0 {
            for i in 0...(arrPSavingList.count - 1){
                let aSavingModle = arrPSavingList[i]
                aPTotalSavingValue += Int(aSavingModle.saving_value as String!)!
            }
        }
        
        self.lblPExpSavingValue.text = String(aPTotalSavingValue)
        
        
        
        var aSpendingPer = 0
        var aRemaningPer = 0
        var aSavingPer = 0
        
        if aPTotalIncomeValue != 0 {
            aSpendingPer = ((aPTotalSpendingValue * 100) / aPTotalIncomeValue)
            aRemaningPer = (((aPTotalIncomeValue - aPTotalSpendingValue) * 100) / aPTotalIncomeValue)
            aSavingPer = ((aPTotalSavingValue * 100) / aPTotalIncomeValue)
        }
        
        
        let aViewSavingCalculation = [Double(aSpendingPer),Double(aSavingPer),Double(aRemaningPer)]

        
        let aColors = [UIColor(hex: GraphColour.kOrange.rawValue),UIColor(hex: GraphColour.kBlue.rawValue),UIColor(hex: GraphColour.kGreen.rawValue)]
        
        
        self.SetViewExpensesPieChart(values: aViewSavingCalculation, colours: aColors)
        
        
        return arrPSavingList
    } */
    
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
