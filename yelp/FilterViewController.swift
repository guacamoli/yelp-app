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
        println(sender)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /* TableView Methods */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = filtersTableView.dequeueReusableCellWithIdentifier("filterSwitchCell") as FilterSwitchCell
        cell.optionNameLabel.text = "hello"
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
