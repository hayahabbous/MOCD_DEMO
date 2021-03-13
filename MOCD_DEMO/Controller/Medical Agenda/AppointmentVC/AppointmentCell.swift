//
//  AppointmentCell.swift
//  SmartAgenda
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AppointmentCell: UITableViewCell {

    @IBOutlet weak var lblAppointmentTitle: UILabel!
    
    @IBOutlet weak var lblAppointmentDate: UILabel!
    
    @IBOutlet weak var lblAppointmentRecurring: UILabel!
    
    @IBOutlet var lblDay: UILabel!
    
    @IBOutlet var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
