//
//  AboutUsVC.swift
//  SmartAgenda
//
//  Created by indianic on 08/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var webview: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        if AppConstants.isArabic()
        {
            btnBack.imageView?.transform = (btnBack.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBack.imageView?.transform = (btnBack.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }
        
        
        // Set Screen title label value
        lblScreenTitle.text = JMOLocalizedString(forKey: "ABOUT US", value: "")
        
        // Change UI through localizeThingsInView method
        LanguageManager().localizeThingsInView(parentView: self.view)
        
        
        var htmlFile = String()
        
        if AppConstants.isArabic(){
            htmlFile = Bundle.main.path(forResource: "aboutus_ar", ofType: "html")!
        }else{
            htmlFile  = Bundle.main.path(forResource: "aboutus_en", ofType: "html")!
        }
        
        let html = try? String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
        self.webview.loadHTMLString(html!, baseURL: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: IBAction Events
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    
    //MARK: Custom Methods
    
    //MARK: UIWebViewDelegate Methods
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print(request)
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Start")
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Finished")
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
}
