//
//  BusinessInfoCell.swift
//  yelp
//
//  Created by Sahil Amoli on 9/20/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

class BusinessInfoCell: UITableViewCell {
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var costRating: UILabel!
    @IBOutlet weak var additionalTags: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        businessImageView.layer.cornerRadius = 5.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
