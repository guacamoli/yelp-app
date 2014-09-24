//
//  FilterSortCell.swift
//  yelp
//
//  Created by Sahil Amoli on 9/23/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

protocol FilterSortCellDelegate {
    func sortValueChanged(filterSortCell: FilterSortCell, newValue: Bool)
}

class FilterSortCell: UITableViewCell {
    var delegate: FilterSortCellDelegate? = nil
    var settingType = ""
    var currentValue: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func handleChange(mySwitch: UISwitch) {
        currentValue = mySwitch.on
        self.delegate?.sortValueChanged(self, newValue: currentValue)
    }
}
