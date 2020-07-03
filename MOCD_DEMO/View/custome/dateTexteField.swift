//
//  dateTexteField.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 5/29/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class dateTexteField: UIView ,WWCalendarTimeSelectorProtocol  , NibLoadable{
    
    @IBOutlet var starImage: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var calendarButton: UIButton!
    
    var viewController: UIViewController!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    @IBAction func calendarButtonAction(_ sender: Any) {
        showCalendar()
    }
    
    
    func showCalendar() {
        let selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        /*
         Any other options are to be set before presenting selector!
         */
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
       
        viewController.present(selector, animated: true, completion: nil)
    }
    
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
        
        let currdate = Date()
        if date > currdate {
            return false
        }
        
        return true
        
    }
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        
        
        textField.text = date.stringFromFormat("MM/dd/yyyy")
        
        
       
        
        let formatter = DateFormatter()
       
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en")

        let dateString = formatter.string(from: date)
      
        
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year ,.month], from: birthday, to: now)
        let age = ageComponents.year!
        let ageMonth = ageComponents.month ?? 0
        
        //ageTextField.text = String(describing: "\(age) Years and \(ageMonth) Months ")
        
        print(date)
    }
}
