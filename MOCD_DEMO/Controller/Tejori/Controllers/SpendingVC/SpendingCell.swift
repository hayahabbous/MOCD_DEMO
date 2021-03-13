//
//  ChecklistCell.swift
//  Edkhar
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class SpendingCell: UITableViewCell {

    @IBOutlet weak var imgSpendingCategory: UIImageView!
    @IBOutlet weak var lblSpendingCategory: UILabel!
    @IBOutlet weak var viewSpendingRecurringStatus: UIView!
    @IBOutlet weak var lblSpendingValue: UILabel!
    @IBOutlet weak var lblSpendingNote: UILabel!
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
