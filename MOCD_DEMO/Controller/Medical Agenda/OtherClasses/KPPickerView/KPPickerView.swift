//
//  KPPickerView.swift
//  KPPickerView
//
//  Created by Kushal Panchal on 23/12/16.
//  Copyright © 2016 Kushal Panchal. All rights reserved.
//

import UIKit


protocol KPPickerViewDelegate: class {
    
    func pickerView(_ picker: KPPickerView, didSelect object: Any)
    func pickerViewDidCancelSelection(_ picker: KPPickerView)
    
}

class KPPickerView: UIView , UIPopoverPresentationControllerDelegate  {
    
    // MARK: - Default Configuration
    struct Config {
        
        fileprivate let contentHeight: CGFloat = 200
        fileprivate let bouncingOffset: CGFloat = 0
        
        var headerHeight: CGFloat = 44.0
        
        var btnDoneTitle = "Done"
        var btnCancelTitle = "Cancel"
        
        var animationDuration: TimeInterval = 0.35
        
        var contentBackgroundColor: UIColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        var headerBackgroundColor: UIColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        var confirmButtonColor: UIColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_PickerColor)
        var cancelButtonColor: UIColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_PickerColor)
        
        var overlayBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6)
        
    }
    
    
    var config = Config()
    
    weak var delegate: KPPickerViewDelegate?
    
    typealias pickerViewDoneButtonClick = (_ selectedObject: Any , _ objectIndex: Int , _ isCancel : Bool) -> Void
    var pickerBlock : pickerViewDoneButtonClick?
    
    var selectedIndex: Int = 0
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var bottomConstraint: NSLayoutConstraint!
    var overlayButton: UIButton!
    
    fileprivate var objParentVC : UIViewController?
    fileprivate var aControllerObject : UIViewController?
    
    fileprivate var arrPickerData: [String] = [String]()
    
    
    // MARK: - Init
    static func getFromNib() -> KPPickerView {
        return UINib.init(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self, options: nil).last as! KPPickerView
    }
    
    // MARK: - Private Method
    
    
    /// Method will set default confuguration for Picker View
    ///
    /// - Parameter parentVC: Object of ViewController in which you want to Display Picker View
    fileprivate func setup(_ parentVC: UIViewController) {
        
        setDefaultSettingsForPickerView()
        
        // Overlay view constraints setup
        
        overlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayButton.backgroundColor = config.overlayBackgroundColor
        overlayButton.alpha = 0
        
        overlayButton.addTarget(self, action: #selector(btnCancelClick(_:)), for: .touchUpInside)
        
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
        
//        LanguageManager.sharedInstance.localizeThingsInView(parentView: parentVC.view)

        parentVC.view.addConstraints([
            bottomConstraint,
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        addConstraint(
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.height)
        )
        
        move(false)
        
    }
    
    func setDefaultSettingsForPickerView() {
        
        // Loading configuration
        
        headerViewHeightConstraint.constant = config.headerHeight
        
        btnDone.setTitle(JMOLocalizedString(forKey: config.btnDoneTitle, value: ""), for: UIControl.State())
        btnCancel.setTitle(JMOLocalizedString(forKey: config.btnCancelTitle, value: ""), for: UIControl.State())
        
        customizeFonts(in: btnDone, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: btnCancel, aFontName: Medium, aFontSize: 0)
        
        btnDone.setTitleColor(config.confirmButtonColor, for: UIControl.State())
        btnCancel.setTitleColor(config.cancelButtonColor, for: UIControl.State())
        
        headerView.backgroundColor = config.headerBackgroundColor
        backgroundView.backgroundColor = config.contentBackgroundColor
        
    }
    
    /// Method will help in animating the Picker View on screen
    ///
    /// - Parameter isUp: Pass true if you want to show display animation for Picker View or pass false if you want to hide Picker View
    fileprivate func move(_ isUp: Bool) {
        bottomConstraint.constant = isUp ? config.bouncingOffset : config.contentHeight + config.headerHeight
    }
    
    
    // MARK: - Button Click Methods
    
    /// Button Done Click Method
    ///
    /// - Parameter sender: Object of Button Done
    @IBAction func btnDoneClick(_ sender: UIButton) {
        
        let aSelectedValue = arrPickerData[selectedIndex]
        
        pickerBlock?(aSelectedValue , selectedIndex , false)
        
        delegate?.pickerView(self, didSelect: aSelectedValue)
        
        if (aControllerObject != nil) {
            aControllerObject!.dismiss(animated: true, completion: nil)
        } else {
            dismiss()
        }
        
    }
    
    
    /// Button Cancel Click Method
    ///
    /// - Parameter sender: Object of Button Cancel
    @IBAction func btnCancelClick(_ sender: UIButton) {
        
        let aSelectedValue = arrPickerData[selectedIndex]
        
        pickerBlock?(aSelectedValue , selectedIndex , true)
        
        delegate?.pickerViewDidCancelSelection(self)
        
        if (aControllerObject != nil) {
            aControllerObject!.dismiss(animated: true, completion: nil)
        } else {
            dismiss()
        }
        
    }
    
    
    // MARK: - Public Methods
    
    
    /// Method will display Picker View with Animation
    ///
    /// - Parameters:
    ///   - parentVC: Object of controller in which you want to display Picker View
    ///   - withCompletionBlock: Completion block which will be called when user tap on Done / Cancel Button
    
    func show(_ parentVC: UIViewController , sender: UIView? , data: [String] , defaultSelected: String?, withCompletionBlock: @escaping pickerViewDoneButtonClick) {
        
        arrPickerData = data
        pickerBlock = withCompletionBlock
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            show(parentVC)
            break
            
        case .pad: // This will display in PopOver for iPad
            show(parentVC, sender: sender)
            break
            
        case .unspecified:
            
            break
            
        default :
            
            break
            
        }
        
        if let strDefault = defaultSelected {
            for (index, item) in arrPickerData.enumerated() {
                print("Found \(item) at position \(index)")
                if item.uppercased() == strDefault.uppercased() {
                    pickerView.selectRow(index, inComponent: 0, animated: true)
                    selectedIndex = index
                    break
                }
            }
        }
        
    }
    
    
    /// Method will display Picker View with Animation
    ///
    /// - Parameters:
    ///   - parentVC: Object of controller in which you want to display Picker View
    ///   - completion: Block will be called when Picker View will be displayed in the screen. You can do additional operations here if you want after displaying Picker View.
    
    func show(_ parentVC: UIViewController, completion: (() -> ())? = nil) {
        
        parentVC.view.endEditing(true)
        
        objParentVC = parentVC
        
        setup(parentVC)
        move(true)
        
        UIView.animate(
            withDuration: config.animationDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
                
                parentVC.view.layoutIfNeeded()
                self.overlayButton.alpha = 1
                
        }, completion: { (finished) in
            completion?()
        }
        )
        
    }
    
    
    
    /// Method will display Picker View in PopOver
    ///
    /// - Parameters:
    ///   - parentVC: Object of controller in which you want to display Picker View
    ///   - sender: Object of view from which you want to display PopOver Controller
    func show(_ parentVC : UIViewController , sender : UIView?) {
        
        objParentVC = parentVC
        
        setDefaultSettingsForPickerView()
        
        if aControllerObject == nil {
            aControllerObject = UIViewController()
        }
        
        aControllerObject!.view = self
        
        aControllerObject!.preferredContentSize = CGSize(width: min(self.bounds.size.width, UIScreen.main.bounds.width - 20.0), height: self.bounds.size.height) // self.bounds.size
        
        aControllerObject!.modalPresentationStyle = .popover
        
        let aPopOverController : UIPopoverPresentationController = aControllerObject!.popoverPresentationController!
        aPopOverController.permittedArrowDirections = .any
        aPopOverController.delegate = self
        
        aPopOverController.sourceView = sender?.superview
        aPopOverController.sourceRect = (sender?.frame)!
        
        parentVC.present(aControllerObject!, animated: true) {
            
        }
        
        
    }
    
    
    
    /// Method will dismiss the
    ///
    /// - Parameter completion: Completion block will be called after Picker is dismissed from view.
    func dismiss(_ completion: (() -> ())? = nil) {
        
        move(false)
        
        UIView.animate(
            withDuration: config.animationDuration, animations: {
                
                self.layoutIfNeeded()
                self.objParentVC?.view.layoutIfNeeded()
                self.overlayButton.alpha = 0
                
        }, completion: { (finished) in
            completion?()
            self.removeFromSuperview()
            self.overlayButton.removeFromSuperview()
        }
        )
        
    }
    
    
    // MARK: - UIPopoverPresentationControllerDelegate Method
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
}

// MARK: - UIPickerViewDataSource Methods
extension KPPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPickerData.count
    }
    
}

// MARK: - UIPickerViewDelegate Methods
extension KPPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        

        customizeFonts(in: pickerView, aFontName: Medium, aFontSize: 0)

        return JMOLocalizedString(forKey: arrPickerData[row], value: "")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
}
