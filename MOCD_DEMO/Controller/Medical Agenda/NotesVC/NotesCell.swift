//
//  NotesCell.swift
//  SmartAgenda
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var lblNotesTitle: UILabel!
    @IBOutlet weak var lblNotesDateVal: UILabel!
    @IBOutlet weak var lblNotesDiscription: UILabel!

    @IBOutlet weak var lblNotesDate: UILabel!
    @IBOutlet weak var lblNotesDay: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
