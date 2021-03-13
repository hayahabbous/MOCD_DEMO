//
//  ReminderCell.swift
//  Edkhar
//
//  Created by indianic on 11/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {

    @IBOutlet weak var lblReminderTitle: UILabel!
    @IBOutlet weak var lblReminderNote: UILabel!
    @IBOutlet weak var lblReminderTime: UILabel!
    @IBOutlet weak var lblReminderMoneyGoalAmount: UILabel!
    @IBOutlet weak var lblReminderType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
