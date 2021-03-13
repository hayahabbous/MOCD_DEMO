//
//  IndependentCell.swift
//  SmartAgenda
//
//  Created by indianic on 01/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class IndependentCell: UITableViewCell {

    
    //MARK: IBActions
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
