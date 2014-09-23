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
    
    var business: Business! {
        willSet(newValue) {
            businessName.text = newValue.name
            address.text = newValue.displayAddress
            additionalTags.text = newValue.displayCategories
            totalReviews.text = newValue.reviewCount + " Reviews"
            
            // Fade in the business image
            businessImageView.alpha = 0.0
            
            // Some businesses don't have an image for some reasonevhiidfnfuihnjhjrnddnhjtfigbgbnjfdkggvgkjbbj
            if let businessImageUrl = newValue.businessImageUrl {
                businessImageView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string:businessImageUrl)), placeholderImage: nil, success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                    self.businessImageView.image = image
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.businessImageView.alpha = 1.0
                        }, completion: { (Bool) -> Void in
                    })
                    }) { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
                }
            } else {
                println("Business don't have an image to display")
                // @TODO - show default image
            }
            
            // Fade in ratings image
            ratingImage.alpha = 0.0
            ratingImage.setImageWithURLRequest(NSURLRequest(URL: NSURL(string:newValue.ratingsImageUrl)), placeholderImage: nil, success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                self.ratingImage.image = image
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.ratingImage.alpha = 1.0
                    }, completion: { (Bool) -> Void in
                })
                }) { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            }

        }
        
    }

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
