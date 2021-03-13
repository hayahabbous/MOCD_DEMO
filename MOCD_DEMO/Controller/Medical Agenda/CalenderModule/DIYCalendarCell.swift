//
//  DIYCalendarCell.swift
//  SwiftExample
//
//  Created by dingwenchao on 06/11/2016.
//  Copyright © 2016 wenchao. All rights reserved.
//

import Foundation
import FSCalendar
import UIKit

enum SelectionType : Int {
    case none
    case day
    case week
    case month
    case today
}



class DIYCalendarCell: FSCalendarCell {
    
    weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let selectionLayer = CAShapeLayer()
        

        
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel!.layer)
        self.selectionLayer = selectionLayer
        
        self.shapeLayer.isHidden = true
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        self.backgroundView = view;
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.circleImageView.frame = self.contentView.bounds
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.selectionLayer.frame = self.contentView.bounds
        
        if selectionType == .day {
            selectionLayer.fillColor = GeneralConstants.ColorConstants.kColor_LightGray.cgColor
        }else if selectionType == .week {
            selectionLayer.fillColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Event_Colors_Used_2).cgColor
        }else if selectionType == .month {
            selectionLayer.fillColor = GeneralConstants.ColorConstants.kColor_Orange.cgColor
        }else if selectionType == .today {
            selectionLayer.fillColor = GeneralConstants.ColorConstants.kColor_Gray.cgColor
        }else if selectionType == .none {
            selectionLayer.fillColor = GeneralConstants.ColorConstants.kColor_Purple.cgColor
        }
        
        
//       if selectionType == .day {
        
            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
            
            self.selectionLayer.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: diameter, height: diameter), cornerRadius: 0.0).cgPath
//       }else if selectionType == .week {
//        
//            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
//        
//            self.selectionLayer.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: diameter, height: diameter), cornerRadius: 0.0).cgPath
//       }else if selectionType == .month {
//        
//            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
//        
//            self.selectionLayer.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: diameter, height: diameter), cornerRadius: 0.0).cgPath
//       }else if selectionType == .today {
//        
//            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
//        
//            self.selectionLayer.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: diameter, height: diameter), cornerRadius: 0.0).cgPath
//        }
    }
    
}
