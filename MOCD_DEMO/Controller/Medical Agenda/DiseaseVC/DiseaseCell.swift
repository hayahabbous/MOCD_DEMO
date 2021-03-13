//
//  DiseaseCell.swift
//  SmartAgenda
//
//  Created by indianic on 30/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class DiseaseCell: UITableViewCell {

    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblFrequency: UILabel!
    
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
