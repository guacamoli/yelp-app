//
//  FilterSwitchCell.swift
//  yelp
//
//  Created by Sahil Amoli on 9/21/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

class FilterSwitchCell: UITableViewCell {

    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
