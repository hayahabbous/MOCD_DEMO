//
//  ProgressHelper.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/13/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import JGProgressHUD

class ProgressHelper{
    
    
    static func showLoadingHUD(withView: UIView,progress: Double ,text: String) {
        let hud = JGProgressHUD(style: .light)
        hud.vibrancyEnabled = true
        if arc4random_uniform(2) == 0 {
            hud.indicatorView = JGProgressHUDPieIndicatorView()
        }
        else {
            hud.indicatorView = JGProgressHUDRingIndicatorView()
        }
        hud.detailTextLabel.text = "0% Complete"
        hud.textLabel.text = text
        hud.show(in: withView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.incrementHUD(hud, progress: Int(progress),withView: withView)
        }
    }
    
    static func incrementHUD(_ hud: JGProgressHUD, progress previousProgress: Int,withView: UIView ) {
        //let progress = previousProgress + 1
        hud.progress = Float(previousProgress / 10)
        hud.detailTextLabel.text = "\(previousProgress)% Complete"
        
        if previousProgress == 100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                UIView.animate(withDuration: 0.1, animations: {
                    hud.textLabel.text = "Success"
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                })
                
                hud.dismiss(afterDelay: 1.0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    //self.showHUDWithTransform(withView: withView)
                }
            }
        }/*
         else {
         DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(20)) {
         self.incrementHUD(hud, progress: progress ,withView: withView)
         }
         }*/
    }
    
    
    static func showHUDWithTransform(withView: UIView) {
        let hud = JGProgressHUD(style: .light)
        hud.vibrancyEnabled = true
        hud.textLabel.text = "Loading"
        hud.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        
        hud.show(in: withView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            UIView.animate(withDuration: 0.3) {
                hud.indicatorView = nil
                hud.textLabel.font = UIFont.systemFont(ofSize: 30.0)
                hud.textLabel.text = "Done"
                // hud.position = .bottomCenter
            }
        }
        
        hud.dismiss(afterDelay: 4.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.showSimpleHUD(withView: withView , text: "")
        }
    }
    
    static func showSimpleHUD(withView: UIView ,text: String) {
        let hud = JGProgressHUD(style: .light)
        hud.vibrancyEnabled = true
        #if os(tvOS)
        hud.textLabel.text = "Error"
        #else
        hud.textLabel.text = "Error"
        #endif
        hud.detailTextLabel.text = text
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: withView)
        
        hud.dismiss(afterDelay: 4.0)
    }
}
