//
//  PreviousMonthCell.swift
//  Edkhar
//
//  Created by indianic on 17/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import Charts

class PreviousMonthCell: UITableViewCell {

    @IBOutlet weak var viewMonthPieChart: PieChartView!
    @IBOutlet weak var lblMonthRemainingValue: UILabel!
    @IBOutlet weak var lblMonthRemainingColour: UILabel!
    @IBOutlet weak var lblMonthSavingValue: UILabel!
    @IBOutlet weak var lblMonthSavingColour: UILabel!
    @IBOutlet weak var lblMonthSpendingValue: UILabel!
    @IBOutlet weak var lblMonthSpendingColour: UILabel!
    @IBOutlet weak var lblMonthTitle: UILabel!
    @IBOutlet weak var lblMonthIncomeValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
