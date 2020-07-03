//
//  ChecklistCell.swift
//  Edkhar
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class IncomeCell: UITableViewCell {

    @IBOutlet weak var imgIncomeType: UIImageView!
    @IBOutlet weak var lblIncomeCategory: UILabel!
    @IBOutlet weak var lblincomeNote: UILabel!
    @IBOutlet weak var lblIncomeValue: UILabel!
    @IBOutlet weak var viewIncomeRecurringStatus: UIView!
    @IBOutlet weak var lblRecurring: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
