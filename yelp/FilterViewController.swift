//
//  FilterViewController.swift
//  yelp
//
//  Created by Sahil Amoli on 9/21/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filtersChanged(filterViewController: FilterViewController, offeringDeal: Bool, sortBy: String, categories: [String:Bool])
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterSwitchCellDelegate, FilterCategoryCellDelegate, FilterSortCellDelegate {
    var delegate: FilterViewControllerDelegate?  = nil
    var isExpanded: [Int: Bool] = [Int: Bool]()
    
    var offeringDeal: Bool! = false
    var categories: [String:Bool]! = [String:Bool]()
    var sortBy = "0"

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
        self.delegate?.filtersChanged(self, offeringDeal: offeringDeal, sortBy: sortBy, categories: categories)
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
        if let expanded = isExpanded[section] {
            isExpanded[section] = !expanded
        } else {
            isExpanded[section] = false
        }
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Automatic)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if let expanded = isExpanded[section] {
                if expanded == true {
                    return 3
                } else {
                    return 1
                }
            } else {
                isExpanded[section] = false
            }
            return 3
        } else if section == 2 {
            return 4
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
                println("WTF")
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
        } else if sectionIndex == 2 {
            
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterCategoryCell") as FilterCategoryCell
            var settingType = ""
            var accessory = UISwitch()
            
            if rowIndex == 0 {
                cellLabel = "Bagels"
                settingType = "bagels"
                cell.settingType = settingType
            } else if rowIndex == 1 {
                cellLabel = "Coffee & Tea"
                settingType = "coffee"
                cell.settingType = settingType
            } else if rowIndex == 2 {
                cellLabel = "Food Trucks"
                settingType = "foodtrucks"
                cell.settingType = settingType
            } else if rowIndex == 3 {
                cellLabel = "Bike Repair"
                settingType = "bikerepair"
                cell.settingType = settingType
            }
            
            if let savedSetting = categories[settingType] {
                accessory.on = savedSetting
            } else {
                categories[settingType] = false
            }
            cell.accessoryView = accessory
            accessory.addTarget(cell, action: Selector("handleChange:"), forControlEvents: UIControlEvents.ValueChanged)
            cell.delegate = self
            
            cell.textLabel?.text = cellLabel
            return cell;
        }
        println(sectionIndex)
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            if section == 1 {
               return "Sort by"
            } else if section == 2 {
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
            isExpanded[1] = false
            filtersTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
