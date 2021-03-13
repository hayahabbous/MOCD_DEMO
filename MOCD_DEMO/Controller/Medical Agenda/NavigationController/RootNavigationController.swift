//
//  RootNavigationController.swift
//  WarnieMojis
//
//  Created by indianic on 09/11/16.
//  Copyright © 2016 Kushal Panchal. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return (self.viewControllers.last?.shouldAutorotate)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            return (self.viewControllers.last?.supportedInterfaceOrientations)!
        }else{
            return .portrait
        }
    }
}
