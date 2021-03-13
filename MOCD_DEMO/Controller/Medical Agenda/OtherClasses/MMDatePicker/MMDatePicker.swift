//
//  MMDatePicker.swift
//  Agenda medica
//
//  Created by Manish on 23/12/16.
//  Copyright © 2016 Manish. All rights reserved.
//

import UIKit

protocol MMDatePickerDelegate: class {
    
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date)
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker)
    
}

class MMDatePicker: UIView {
    
    // MARK: - Config
    struct Config {
        
        fileprivate let contentHeight: CGFloat = 250
        fileprivate let bouncingOffset: CGFloat = 20
        
        var startDate: Date?
        var minDate: Date?
        var maxDate: Date?
        var dateMode: UIDatePicker.Mode?
        var timeFormat: NSLocale?
        var confirmButtonTitle = "Done"//JMOLocalizedString(forKey: "Done", value: "")
        var cancelButtonTitle = "Cancel"//JMOLocalizedString(forKey: "Cancel", value: "")
        
        var headerHeight: CGFloat = 50
        
        var animationDuration: TimeInterval = 0.6
        
        var contentBackgroundColor: UIColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        var headerBackgroundColor: UIColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        var confirmButtonColor: UIColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_PickerColor)
        var cancelButtonColor: UIColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_PickerColor)
        
        var overlayBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6)
        
    }
    
    var config = Config()
    
    weak var delegate: MMDatePickerDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var bottomConstraint: NSLayoutConstraint!
    var overlayButton: UIButton!
    
    
    var popover: UIPopoverPresentationController!
    
    // MARK: - Init
    static func getFromNib() -> MMDatePicker {
        return UINib.init(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self, options: nil).last as! MMDatePicker
    }
    
    // MARK: - IBAction
    @IBAction func confirmButtonDidTapped(_ sender: AnyObject) {
        
        config.startDate = datePicker.date
        
        dismiss()
        delegate?.mmDatePicker(self, didSelect: datePicker.date)
        
    }
    @IBAction func cancelButtonDidTapped(_ sender: AnyObject) {
        dismiss()
        delegate?.mmDatePickerDidCancelSelection(self)
    }
    
    // MARK: - Private
    fileprivate func setup(_ parentVC: UIViewController) {
        
        var formatter = DateFormatter()

        // Loading configuration
        
        
        
        if AppConstants.isArabic() {
            datePicker?.locale = Locale.init(identifier: "ar")
            formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
            
        }else{
            datePicker?.locale = Locale.init(identifier: "en")
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        }
        
        if let timeFormat = config.timeFormat {
            datePicker.locale = timeFormat as Locale
        }
        
        if let startDate = config.startDate {
            datePicker.date = startDate
        }

        if let minDate = config.minDate {
            datePicker.minimumDate = minDate
        }

        if let maxDate = config.maxDate {
            datePicker.maximumDate = maxDate
        }

        if let dateMode = config.dateMode {
            datePicker.datePickerMode = dateMode
        }
        
        headerViewHeightConstraint.constant = config.headerHeight
        
        confirmButton.setTitle(JMOLocalizedString(forKey: config.confirmButtonTitle, value: ""), for: UIControl.State())
        cancelButton.setTitle(JMOLocalizedString(forKey: config.cancelButtonTitle, value: ""), for: UIControl.State())
        
        customizeFonts(in: confirmButton, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: cancelButton, aFontName: Medium, aFontSize: 0)
        
        confirmButton.setTitleColor(config.confirmButtonColor, for: UIControl.State())
        cancelButton.setTitleColor(config.cancelButtonColor, for: UIControl.State())
        
        headerView.backgroundColor = config.headerBackgroundColor
        backgroundView.backgroundColor = config.contentBackgroundColor
        
        // Overlay view constraints setup
        
        overlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayButton.backgroundColor = config.overlayBackgroundColor
        overlayButton.alpha = 0
        
        overlayButton.addTarget(self, action: #selector(cancelButtonDidTapped(_:)), for: .touchUpInside)
        
        if !overlayButton.isDescendant(of: parentVC.view) { parentVC.view.addSubview(overlayButton) }
        
        overlayButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentVC.view.addConstraints([
            NSLayoutConstraint(item: overlayButton, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .top, relatedBy: .equal, toItem: parentVC.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        
        // Setup picker constraints
        
        frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: config.contentHeight + config.headerHeight)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        if !isDescendant(of: parentVC.view) { parentVC.view.addSubview(self) }
        
        parentVC.view.addConstraints([
            bottomConstraint,
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        addConstraint(
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.height)
        )
        
        
        move(goUp: false)
        
    }
    
    fileprivate func move(goUp: Bool) {
        bottomConstraint.constant = goUp ? config.bouncingOffset : config.contentHeight + config.headerHeight
    }
    
    // MARK: - Public
    func show(inVC parentVC: UIViewController, completion: (() -> ())? = nil) {
        
        LanguageManager().localizeThingsInView(parentView: parentVC.view)
        
        parentVC.view.endEditing(true)
        
        setup(parentVC)
        move(goUp: true)
        
        UIView.animate(
            withDuration: config.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                parentVC.view.layoutIfNeeded()
                self.overlayButton.alpha = 1
                
            }, completion: { (finished) in
                completion?()
            }
        )
        
    }
    
    func dismiss(_ completion: (() -> ())? = nil) {
        
        move(goUp: false)
        
        UIView.animate(
            withDuration: config.animationDuration, animations: {
                
                self.layoutIfNeeded()
                self.overlayButton.alpha = 0
                
            }, completion: { (finished) in
                completion?()
                self.removeFromSuperview()
                self.overlayButton.removeFromSuperview()
            }
        )
        
    }
    
}
