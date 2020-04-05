//
//  AboutUsVC.swift
//  Edkhar
//
//  Created by indianic on 31/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class AboutUsVCT: UIViewController {
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if AppConstants.isArabic(){
            self.btnBackEN.isHidden = true
        }
        else{
            self.btnBackAR.isHidden = true
        }
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "About US", value: "")
        var htmlFile = String()
        
        if AppConstants.isArabic(){
            htmlFile = Bundle.main.path(forResource: "aboutus_ar", ofType: "html")!
        }else{
            htmlFile  = Bundle.main.path(forResource: "aboutus_en", ofType: "html")!
        }
        
        let html = try? String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
        
        self.webView.loadHTMLString(html!, baseURL: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

}
