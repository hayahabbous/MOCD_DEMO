//
//  DatePickerPopover.swift
//  SwiftyPickerPopover
//
//  Created by Manish on 23/12/16.
//  Copyright © 2016 Manish. All rights reserved.
//

import Foundation
import UIKit

public class MMAbstractPopover:NSObject {
    
    /// configure navigationController
    /// - parameter originView: origin view of Popover
    /// - parameter baseView: popoverPresentationController's sourceView
    /// - parameter baseViewController: viewController to become the base
    /// - parameter title: title of navigation bar
    func configureNavigationController(_ originView: UIView, baseView: UIView? = nil, baseViewController: UIViewController, title: String?)->UINavigationController?{
        // create ViewController for content
        let bundle = Bundle(for: MMAbstractPopover.self)
        let storyboard = UIStoryboard(name: self.storyboardName(), bundle: bundle)
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        // define using popover
        navigationController.modalPresentationStyle = .popover
        
        // origin
        navigationController.popoverPresentationController?.sourceView = baseView ?? originView
        navigationController.popoverPresentationController?.sourceRect = originView.frame
        
        // direction of arrow
        navigationController.popoverPresentationController?.permittedArrowDirections = .any
        
        // navigationItem's title
        navigationController.topViewController!.navigationItem.title = title
        
        return navigationController
    }
    
    /// storyboardName
    func storyboardName()->String{
        return "StringPickerPopover"
    }
    
}


public class MMDatePickerPopover: MMAbstractPopover {
    // singleton
    class var sharedInstance : MMDatePickerPopover {
        struct Static {
            static let instance : MMDatePickerPopover = MMDatePickerPopover()
        }
        return Static.instance
    }
    
    // selected date
    var selectedDate: Date = Date()
    /// Popover appears
    /// - parameter view: origin view of popover
    /// - parameter baseView: popoverPresentationController's sourceView
    /// - parameter baseViewController: viewController to become the base
    /// - parameter title: title for navigation bar
    /// - parameter dateMode: UIDatePickerMode
    /// - parameter initialDate: initial selected date
    /// - parameter doneAction: action in which user tappend done button
    /// - parameter cancelAction: action in which user tappend cancel button
    /// - parameter clearAction: action in which user tappend clear action. Omissible.
    public class func appearOn(originView: UIView,
                               baseView: UIView? = nil,
                               baseViewController: UIViewController,
                               title: String?,
                               dateMode:UIDatePicker.Mode,
                               initialDate:Date?,
                               maxDate: Date?,
                               timeFormat: NSLocale?,
                               doneAction: ((Date)->Void)?,
                               cancelAction: (()->Void)?,
                               clearAction: (()->Void)? = nil){
        
        // create navigationController
        guard let navigationController = sharedInstance.configureNavigationController(originView, baseView: baseView, baseViewController: baseViewController, title: title) else {
            return
        }
        
        // StringPickerPopoverViewController
        if let contentViewController = navigationController.topViewController as? DatePickerPopoverViewController {
            
            
            // UIPickerView
            
            //            contentViewController.selectedDate = initialDate
            contentViewController.minDate = initialDate
            contentViewController.dateMode = dateMode
            
            //            if contentViewController.maxDate == maxDate {
            contentViewController.maxDate = maxDate
            //            }
            
            if contentViewController.dateMode == .time {
                contentViewController.timeFormat = timeFormat!
            }
            
            contentViewController.doneAction = doneAction
            contentViewController.cancleAction = cancelAction
            if let action = clearAction {
                contentViewController.clearAction = action
            }
            else {
                contentViewController.hideClearButton = true
            }
            
            navigationController.popoverPresentationController?.delegate = contentViewController
        }
        
        // presnet popover
        baseViewController.present(navigationController, animated: true, completion: nil)
        
    }
    
    /// storyboardName
    override func storyboardName()->String{
        return "DatePickerPopover"
    }
    
}
