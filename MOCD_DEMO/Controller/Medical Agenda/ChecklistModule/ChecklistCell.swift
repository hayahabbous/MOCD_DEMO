//
//  ChecklistCell.swift
//  SmartAgenda
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class ChecklistCell: UITableViewCell {

    @IBOutlet weak var btnChecklist: UIButton!
    @IBOutlet weak var lblCheckList: UILabel!
    @IBOutlet var lblCheckList1: UILabel!
    @IBOutlet var lblCheckList2: UILabel!

    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblTime1: UILabel!
    @IBOutlet var lblTime2: UILabel!

    @IBOutlet var timeConstraint: NSLayoutConstraint!

    @IBOutlet var txtFieldSugar: UITextField!
    
    @IBOutlet var txtFieldLow: UITextField!
    
    @IBOutlet var txtFieldHigh: UITextField!
    
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var view0: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func btn(_ sender: UIButton) {
        
        
    }
    
}
