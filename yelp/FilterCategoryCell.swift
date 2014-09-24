//
//  FilterCategoryCell.swift
//  yelp
//
//  Created by Sahil Amoli on 9/23/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

protocol FilterCategoryCellDelegate {
    func categoryValueChanged(filterCategoryCell: FilterCategoryCell, newValue: Bool)
}

class FilterCategoryCell: UITableViewCell {
    var delegate: FilterCategoryCellDelegate? = nil
    
    var currentValue: Bool = false
    var settingType = ""
    
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
        self.delegate?.categoryValueChanged(self, newValue: currentValue)
    }
}
