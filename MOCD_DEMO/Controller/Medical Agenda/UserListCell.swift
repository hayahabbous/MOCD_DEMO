//
//  UserListCell.swift
//  SwiftDatabase
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {

    @IBOutlet weak var lblUserDob: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
