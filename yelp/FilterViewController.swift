//
//  FilterViewController.swift
//  yelp
//
//  Created by Sahil Amoli on 9/21/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filtersChanged(filterViewController: FilterViewController, offeringDeal: Bool, radiusFilter: String, sortBy: String, categories: [String:Bool])
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterSwitchCellDelegate, FilterCategoryCellDelegate, FilterSortCellDelegate, FilterDistanceCellDelegate {
    var delegate: FilterViewControllerDelegate?  = nil
    var isExpanded: [Int: Bool] = [Int: Bool]()
    
    var offeringDeal: Bool! = false
    var categories: [String:Bool]! = [String:Bool]()
    var sortBy = "0"
    var radiusFilter = ""
    
    var allCategories: [[String:String]]! = [["Bagels": "bagels"], ["Food Trucks": "foodtrucks"], ["Bakeries": "bakeries"], ["Beer, Wine & Spirits": "beer_and_wine"], ["Beverage Store": "beverage_stores"], ["Breweries": "breweries"], ["Bubble Tea": "bubbletea"], ["Cupcakes": "cupcakes"], ["Ice Cream & Frozen Yogurt": "icecream"]]
    var distanceRadius: [[String:String]]! = [["Auto": ""], ["0.3 miles": "480"], ["1 mile": "1600"], ["5 miles": "8000"], ["20 miles": "32000"], ]

    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var filtersNavBar: UINavigationItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        // Set navigation bar color
        var color: UIColor = UIColor(red: CGFloat(196/255.0), green: CGFloat(18/255.0), blue: CGFloat(0), alpha: CGFloat(1))
        navigationController?.navigationBar.barTintColor = color

        filtersTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSearchClicked(sender: AnyObject) {
        self.delegate?.filtersChanged(self, offeringDeal: offeringDeal, radiusFilter: radiusFilter, sortBy: sortBy, categories: categories)
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }

    @IBAction func onCancelClick(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    /* TableView Methods */

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        filtersTableView.deselectRowAtIndexPath(indexPath, animated: true)

        var section = indexPath.section
        var row = indexPath.row
        if let expanded = isExpanded[section] {
            if expanded == true {
                if section != 3 {
                    isExpanded[section] = !expanded
                }
            } else {
                if section == 3 && row != 4 {
                } else {
                    isExpanded[section] = !expanded
                }
            }
        } else {
            isExpanded[section] = false
        }
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Automatic)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var isSectionExpanded = false
        if let expanded = isExpanded[section] {
            
        } else {
            // Set false by default since all sections should be collapsed initially
            isExpanded[section] = false
        }

        if section == 1 {
            if isExpanded[section] == true {
                return 5
            } else {
                return 1
            }
        }
        if section == 2 {
            if isExpanded[section] == true {
                return 3
            } else {
                return 1
            }
        } else if section == 3 {
            if isExpanded[section] == true {
                return allCategories.count
            } else {
                return 5
            }
        }

        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellLabel = ""
        let rowIndex = indexPath.row
        let sectionIndex = indexPath.section

        if sectionIndex == 0 && rowIndex == 0 {
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterSwitchCell") as FilterSwitchCell
            var settingType = "offering_deal"
            var accessory = UISwitch()
            cell.settingType = settingType

            if offeringDeal == true {
                accessory.on = true
            }

            cellLabel = "Offering a Deal"
            cell.accessoryView = accessory
            accessory.addTarget(cell, action: Selector("handleChange:"), forControlEvents: UIControlEvents.ValueChanged)
            cell.delegate = self
            cell.textLabel?.text = cellLabel
            return cell;
        } else if sectionIndex == 1 {
            var showViewOnlyCell = false
            if let expanded = isExpanded[sectionIndex] {
                if expanded == false {
                    showViewOnlyCell = true
                }
            } else {
                showViewOnlyCell = true
            }
            
            if (showViewOnlyCell) {
                var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterDistanceCell") as FilterDistanceCell
                if radiusFilter == "480" {
                    cellLabel = "0.3 Miles"
                } else if radiusFilter == "1600" {
                    cellLabel = "1 Mile"
                } else if radiusFilter == "8000" {
                    cellLabel = "5 Miles"
                } else if radiusFilter == "32000" {
                    cellLabel = "25 Miles"
                } else {
                    cellLabel = "Auto"
                }
                cell.textLabel?.text = cellLabel
                return cell;
            } else {
                var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterDistanceCell") as FilterDistanceCell
                
                var settingType = ""
                var accessory = UISwitch()
                var distanceInfo = distanceRadius[rowIndex]
                var displayName : String = Array(distanceInfo.keys)[0]
                cellLabel = displayName
                settingType = distanceInfo[displayName]!
                cell.settingType = settingType

                if radiusFilter == settingType {
                    accessory.on = true
                }
    
                cell.accessoryView = accessory
                accessory.addTarget(cell, action: Selector("handleChange:"), forControlEvents: UIControlEvents.ValueChanged)
                cell.delegate = self
                cell.textLabel?.text = cellLabel
                return cell
            }
        } else if sectionIndex == 2 {
            var showViewOnlyCell = false
            if let expanded = isExpanded[sectionIndex] {
                if expanded == false {
                    showViewOnlyCell = true
                }
            } else {
                showViewOnlyCell = true
            }
            
            if (showViewOnlyCell) {
                var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterSortCell") as FilterSortCell
                if (sortBy == "1") {
                    cellLabel = "Distance"
                } else if (sortBy == "2") {
                    cellLabel = "Rating"
                } else {
                    cellLabel = "Best Match"
                }
                
                cell.textLabel?.text = cellLabel
                return cell;
            }
            
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterSortCell") as FilterSortCell
            var settingType = "sort_by"
            var accessory = UISwitch()
            
            if rowIndex == 0 {
                cellLabel = "Best Match"
                settingType = "0"
                cell.settingType = settingType
            } else if rowIndex == 1 {
                cellLabel = "Distance"
                settingType = "1"
                cell.settingType = settingType
            } else if rowIndex == 2 {
                cellLabel = "Rating"
                settingType = "2"
                cell.settingType = settingType
            }

            if sortBy == settingType {
                accessory.on = true
            }

            cell.accessoryView = accessory
            accessory.addTarget(cell, action: Selector("handleChange:"), forControlEvents: UIControlEvents.ValueChanged)
            cell.delegate = self
            
            cell.textLabel?.text = cellLabel
            return cell;
        } else if sectionIndex == 3 {
            var showAllButtonVisible = true
            if let expanded = isExpanded[sectionIndex] {
                if expanded == true {
                    showAllButtonVisible = false
                }
            } else {
                isExpanded[sectionIndex] = false
                showAllButtonVisible = true
            }

            var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterCategoryCell") as FilterCategoryCell
            
            if showAllButtonVisible && rowIndex == 4 {
                cellLabel = "Show All"
            } else {
                var settingType = ""
                var accessory = UISwitch()
                var categoryInfo = allCategories[rowIndex]
                var displayName : String = Array(categoryInfo.keys)[0]
                cellLabel = displayName
                settingType = categoryInfo[displayName]!
                cell.settingType = settingType
                
                if let savedSetting = categories[settingType] {
                    accessory.on = savedSetting
                } else {
                    categories[settingType] = false
                }
                cell.accessoryView = accessory
                accessory.addTarget(cell, action: Selector("handleChange:"), forControlEvents: UIControlEvents.ValueChanged)
                cell.delegate = self
            }
            cell.textLabel?.text = cellLabel
            return cell;
        }
        println(sectionIndex)
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            if section == 1 {
                return "Distance"
            } else if section == 2 {
               return "Sort by"
            } else if section == 3 {
                return "Categories"
            }
        }
        return ""
    }

    func switchDidChange(filterSwitchView: FilterSwitchCell, newValue: Bool) {
        offeringDeal = newValue

    }
    
    func categoryValueChanged(filterCategoryCell: FilterCategoryCell, newValue: Bool) {
        categories[filterCategoryCell.settingType] = newValue
    }
    
    func sortValueChanged(filterSortCell: FilterSortCell, newValue: Bool) {
        if newValue == true {
            sortBy = filterSortCell.settingType
            isExpanded[2] = false
            filtersTableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    func distanceValueChanged(distanceSortCell: FilterDistanceCell, newValue: Bool) {
        if newValue == true {
            radiusFilter = distanceSortCell.settingType
            isExpanded[1] = false
            filtersTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
