//
//  SideMenuCellTableViewCell.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var lblSidemenuTitle: UILabel!
    
    @IBOutlet var imgViewIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
