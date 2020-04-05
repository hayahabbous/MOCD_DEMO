//
//  pdfViewer.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/23/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import PDFKit
import NVActivityIndicatorView
class pdfViewer: UIViewController {

    @IBOutlet var pdfView: PDFView!
    let activityData = ActivityData()
    var s: story!
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }*/
        
        let url = URL(string: "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(s?.link ?? "" )")
        
        if url != nil {
            getPDF(from: url!)
        }else{
            
        }
        
        
    }
    
    func getPDF(from url: URL) {
             
        print("Download Started")
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        DispatchQueue.global().async {
        
            if let pdfDocument = PDFDocument(url: url) {
                DispatchQueue.main.async {
                    
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self.pdfView.displayMode = .singlePageContinuous
                    self.pdfView.autoScales = true
                    self.pdfView.displayDirection = .horizontal
                    //pdfView.displaysAsBook = true
                    self.pdfView.document = pdfDocument
                }
                
            }
        }
    }
}
