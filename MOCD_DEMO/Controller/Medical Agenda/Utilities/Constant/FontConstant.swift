    //
//  FontConstant.swift
//  SmartAgenda
//
//  Created by indianic on 17/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import UIKit

let Light = "light"
let Medium = "Medium"
let Bold = "Bold"
let SemiBold = "SemiBold"
let Black = "Black"
let Cond = "Cond"
let SemiCn = "SemiCn"

    func customizeFonts(in tmpView: UIView, aFontName: String, aFontSize: CGFloat) {
    
    var fontName: String = ""
    
    let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language") as? String
    
    
    if((aStrUserdefultLanguage != nil) && aStrUserdefultLanguage == "ar")
    {
        
        if aFontName == Light {
            fontName = FontName.kGESSUltraLight.rawValue
        }else if aFontName == Medium {
            fontName = FontName.kGESSMedium.rawValue
        }
        else if aFontName == Bold {
            fontName = FontName.kGESSBold.rawValue
        }
    }
    else {
        
        if aFontName == Light {
            fontName = FontName.kMyriadProLight.rawValue
        }else if aFontName == Medium {
            fontName = FontName.kMyriadProRegular.rawValue
        }
        else if aFontName == Bold {
            fontName = FontName.kMyriadProBold.rawValue
        }
        else if aFontName == SemiBold {
            fontName = FontName.kMyriadProSemibold.rawValue
        }
        else if aFontName == Black {
            fontName = FontName.kMyriadProBlack.rawValue
        }
        else if aFontName == Cond {
            fontName = FontName.kMyriadProCond.rawValue
        }
        else if aFontName == SemiCn {
            fontName = FontName.kMyriadProSemiCn.rawValue
        }
    }
    
    
    if (tmpView is UILabel) {
        (tmpView as? UILabel)?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UILabel)?.font?.pointSize)! + aFontSize))
    }
    else if (tmpView is UIButton) {
        (tmpView as? UIButton)?.titleLabel?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UIButton)?.titleLabel?.font?.pointSize)! + aFontSize))
    }
    else if (tmpView is UITextView) {
        (tmpView as? UITextView)?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UITextView)?.font?.pointSize)! + aFontSize))
    }
    else if (tmpView is UITextField) {
        (tmpView as? UITextField)?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UITextField)?.font?.pointSize)! + aFontSize))
    }
    else{
        for v in tmpView.subviews {
            if (v is UILabel) {
                (v as? UILabel)?.font = UIFont(name: fontName, size: CGFloat(((v as? UILabel)?.font?.pointSize)! + aFontSize))
                if ((v as? UILabel)?.text == "*") {
                    
                }
            }
            else if (v is UIButton) {
                (v as? UIButton)?.titleLabel?.font = UIFont(name: fontName, size: CGFloat(((v as? UIButton)?.titleLabel?.font?.pointSize)! + aFontSize))
            }
            else if (v is UITextView) {
                (v as? UITextView)?.font = UIFont(name: fontName, size: CGFloat(((v as? UITextView)?.font?.pointSize)! + aFontSize))
            }
            else if (v is UITextField) {
                
                (v as? UITextField)?.font = UIFont(name: fontName, size: CGFloat(((v as? UITextField)?.font?.pointSize)! + aFontSize))
            }
            else if v.subviews.count > 0 {
                customizeFonts(in: v, aFontName: aFontName, aFontSize: aFontSize)
            }
        }
    }
    
}
