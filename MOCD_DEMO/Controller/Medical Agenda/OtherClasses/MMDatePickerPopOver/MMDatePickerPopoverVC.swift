//
//  DatePickerPopoverViewController.swift
//  SwiftyPickerPopover
//
//  Created by Manish on 23/12/16.
//  Copyright © 2016 Manish. All rights reserved.
//

import Foundation
import UIKit

class DatePickerPopoverViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var doneAction: ((Date)->Void)?
    var cancleAction: (()->Void)?
    var clearAction: (()->Void)?
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnDone: UIButton!
    
    
    var minDate: Date?
    var maxDate: Date?
    var selectedDate = Date()
    var dateMode: UIDatePicker.Mode = .date
    var timeFormat: NSLocale = NSLocale(localeIdentifier: "en_GB")

    var hideClearButton: Bool = false

    @IBOutlet weak var clearButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if hideClearButton {
            clearButton.removeFromSuperview()
            view.layoutIfNeeded()
        }
        
        
        btnDone.setTitle(JMOLocalizedString(forKey: "Done", value: ""), for: .normal)
        btnCancel.setTitle(JMOLocalizedString(forKey: "Cancel", value: ""), for: .normal)

        customizeFonts(in: btnDone, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: btnCancel, aFontName: Medium, aFontSize: 0)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.date = selectedDate
        picker.minimumDate = minDate
        picker.maximumDate = maxDate
        picker.datePickerMode = dateMode
    }
    
    
    @IBAction func tappedDone(_ sender: UIButton? = nil) {
        doneAction?(picker.date)
        dismiss(animated: true, completion: {})
    }
    
    @IBAction func tappedCancel(_ sender: UIButton? = nil) {
        cancleAction?()
        dismiss(animated: true, completion: {})
    }
    
    @IBAction func tappedClear(_ sender: UIButton? = nil) {
        clearAction?()
        dismiss(animated: true, completion: {})
    }
    
    /// popover dismissed
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        tappedCancel()
    }
    
    /// Popover appears on iPhone
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
