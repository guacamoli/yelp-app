//
//  Business.swift
//  yelp
//
//  Created by Sahil Amoli on 9/22/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

class Business: NSObject {
    var name: String!
    var businessImageUrl: String!
    var ratingsImageUrl: String!
    var displayCategories: String!
    var displayAddress: String!
    var reviewCount: String!
    
    init(business: NSDictionary) {
        name = business["name"] as? String
        businessImageUrl = business["image_url"] as? String
        ratingsImageUrl = business["rating_img_url"] as? String
        var totalReviews = business["review_count"] as? Int
        reviewCount = String(totalReviews!)
        
        let categories = business["categories"] as [[String]]
        let location = business["location"] as NSDictionary
        let displayAddressList = location["display_address"] as [String]
        
        super.init()

        displayCategories = getCategoriesDisplayString(categories)
        displayAddress = getDisplayAddressString(displayAddressList)

    }
    
    func getDisplayAddressString(displayAddressList: [String]) -> String {
        var count = displayAddressList.count
        var displayAddress = ""
        // We don't want to include the last part of the address which is always the zip code
        for index in 0...count-2 {
            displayAddress = displayAddress + displayAddressList[index]
            if index < count-2 {
                displayAddress += ", "
            }
        }
        return displayAddress
    }
    
    func getCategoriesDisplayString(categories: [[String]]) -> String {
        var categoriesString = ""
        var count = categories.count
        
        for index in 0...count-1 {
            var category = categories[index]
            categoriesString += category[0]
            if index < count-1 {
                categoriesString += ", "
            }
        }
        return categoriesString
    }
}
