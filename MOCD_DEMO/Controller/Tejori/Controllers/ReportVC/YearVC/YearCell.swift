//
//  YearCell.swift
//  Edkhar
//
//  Created by indianic on 17/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import Charts

class YearCell: UITableViewCell {

    @IBOutlet weak var viewYearPieChart: PieChartView!
    @IBOutlet weak var lblYearRemainingValue: UILabel!
    @IBOutlet weak var lblYearRemainingColour: UILabel!
    @IBOutlet weak var lblYearSavingValue: UILabel!
    @IBOutlet weak var lblYearSavingColour: UILabel!
    @IBOutlet weak var lblYearSpendingValue: UILabel!
    @IBOutlet weak var lblYearSpendingColour: UILabel!
    @IBOutlet weak var lblYearTitle: UILabel!
    @IBOutlet weak var lblYearIncomeValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
