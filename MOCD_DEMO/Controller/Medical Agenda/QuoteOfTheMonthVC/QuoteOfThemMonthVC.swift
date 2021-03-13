//
//  QuoteOfThemMonthVC.swift
//  SmartAgenda
//
//  Created by indianic on 08/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class QuoteOfThemMonthVC: UIViewController{

    
    @IBOutlet var txtView: UITextView!
    
    var dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "MM"
        
        print("Month Quote: \(dateFormatter.string(from: Date()))")
        
        LanguageManager().localizeThingsInView(parentView: self.view)
        
//        let aObjQuote: QuoteOfTheMonthModel = AppDelegate().appDelegateShared().quoteOfMonth[Int(dateFormatter.string(from: Date()))! - 1]
        let aObjQuote: QuoteOfTheMonthModel = AppDelegate().appDelegateShared().quoteOfMonth[kSelectedCalMonth - 1]
        
        
        if AppConstants.isArabic() {
            txtView?.text = aObjQuote.QuoteTextAR
        }else{
            txtView?.text = aObjQuote.QuoteText
        }
        
        txtView.contentOffset = CGPoint.zero
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tapGestureClick(_ sender: UITapGestureRecognizer) {
        
        
            self.dismiss(animated: true) {
                
            }
            
    }
    
    
    @IBAction func btnCloseClick(_ sender: UIButton) {
     
        self.dismiss(animated: true) {
            
        }
        
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
