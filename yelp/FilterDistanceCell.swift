//
//  FilterDistanceCell.swift
//  yelp
//
//  Created by Sahil Amoli on 9/25/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

protocol FilterDistanceCellDelegate {
    func distanceValueChanged(filterDistanceCell: FilterDistanceCell, newValue: Bool)
}

class FilterDistanceCell: UITableViewCell {
    var delegate: FilterDistanceCellDelegate? = nil
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
        self.delegate?.distanceValueChanged(self, newValue: currentValue)
    }
}
