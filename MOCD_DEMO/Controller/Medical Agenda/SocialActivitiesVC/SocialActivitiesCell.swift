//
//  SocialActivitiesCell.swift
//  SmartAgenda
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class SocialActivitiesCell: UITableViewCell {

    @IBOutlet weak var lblSocialActivitiesTitle: UILabel!
    
    @IBOutlet weak var lblSocialActivitiesDate: UILabel!
    
    @IBOutlet var lblDay: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
