//
//  CalculationTableViewCell.swift
//  Fractal
//
//  Created by Sean on 6/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

class CalculationTableViewCell: UITableViewCell {

    @IBOutlet weak var copiedLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
