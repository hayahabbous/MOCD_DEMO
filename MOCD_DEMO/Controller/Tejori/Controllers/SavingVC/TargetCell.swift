//
//  TargetCell.swift
//  Edkhar
//
//  Created by indianic on 30/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class TargetCell: UITableViewCell {

    @IBOutlet weak var targetProgressbar: UIProgressView!
    @IBOutlet weak var lblTargetCategory: UILabel!
    @IBOutlet weak var lblTargetPersentage: UILabel!
    @IBOutlet weak var lblTotalTargetAmount: UILabel!
    @IBOutlet weak var lblTotalSavedAmount: UILabel!
    @IBOutlet weak var viewTargetProgress: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
