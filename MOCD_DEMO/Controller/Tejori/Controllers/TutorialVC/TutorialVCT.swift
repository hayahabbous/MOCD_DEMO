//
//  ViewController.swift
//  Paging_Swift
//
//  Created by olxios on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


class TutorialVCT: UIViewController, UIPageViewControllerDataSource {
    @IBOutlet weak var viewPageController: UIView!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    
    // MARK: - Variables
    fileprivate var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    fileprivate var contentImages = [String]()
    
    
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if AppConstants.isArabic() {
            contentImages = ["img_tutorial_ar_1",
                             "img_tutorial_ar_2",
                             "img_tutorial_ar_3",
                             "img_tutorial_ar_4",
                             "img_tutorial_ar_5"]
            
        }else{
            contentImages = ["img_tutorial_en_1",
                             "img_tutorial_en_2",
                             "img_tutorial_en_3",
                             "img_tutorial_en_4",
                             "img_tutorial_en_5"]
            
        }
        
        createPageViewController()
        setupPageControl()
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
       
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: lblScreenTitle, aFontName: Light, aFontSize: 8)
            Utility.sharedInstance.customizeFonts(in: btnSkip, aFontName: SemiBold, aFontSize: 6)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: lblScreenTitle, aFontName: Light, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnSkip, aFontName: SemiBold, aFontSize: 0)
        }
    }
    
    fileprivate func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChild(pageViewController!)
        viewPageController.frame = self.view.bounds
        pageViewController!.view.frame = viewPageController.bounds
        viewPageController.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
        
    }
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.green
        appearance.backgroundColor = UIColor.clear
    
        
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemControllerT
        
//        if itemController.itemIndex-1 == contentImages.count{
//            btnSkip.setTitle(JMOLocalizedString(forKey: "Get Started", value: ""), for: .normal)
//        }else {
//            btnSkip.setTitle(JMOLocalizedString(forKey: "SKIP", value: ""), for: .normal)
//        }
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemControllerT
        
       
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    fileprivate func getItemController(_ itemIndex: Int) -> PageItemControllerT? {
       
        if ((itemIndex+1) == contentImages.count){
            btnSkip.setTitle(JMOLocalizedString(forKey: "Get Started", value: ""), for: .normal)
        }else {
            btnSkip.setTitle(JMOLocalizedString(forKey: "SKIP", value: ""), for: .normal)
        }
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ItemController") as! PageItemControllerT
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PageItemController {
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if self.pageViewController?.viewControllers?.count > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
    
}

