//
//  FilterViewController.swift
//  yelp
//
//  Created by Sahil Amoli on 9/21/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

protocol YelpFiltersDelegate {
    func test(msg: String)
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var delegate: YelpFiltersDelegate?  = nil

    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var filtersNavBar: UINavigationItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        //        navigationController?.setViewControllers(FilterViewController, animated: true)
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        // Set navigation bar color
        var color: UIColor = UIColor(red: CGFloat(196/255.0), green: CGFloat(18/255.0), blue: CGFloat(0), alpha: CGFloat(1))
        navigationController?.navigationBar.barTintColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.delegate?.test("sahil")
    }
    
    @IBAction func onSearchClicked(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func onCancelClick(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    /* TableView Methods */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterSwitchCell") as FilterSwitchCell
        cell.optionNameLabel.text = "Fishing"
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
