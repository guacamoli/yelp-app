//
//  BusinessListViewController
//  yelp
//
//  Created by Sahil Amoli on 9/20/14.
//  Copyright (c) 2014 Sahil Amoli. All rights reserved.
//

import UIKit

class YelpListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, YelpFiltersDelegate {

    var client: YelpClient!
    let yelpConsumerKey = "gVCmT34_OrcdPuXmNqsMcw"
    let yelpConsumerSecret = "mpgXYtzSzo_xquTBhh4WLt4YcjE"
    let yelpToken = "-965FQU5EvCXlf0CUL7cN0FxX8DfLTZk"
    let yelpTokenSecret = "QEVESzxgtkiZKwOeEtrCJH66G-c"
    let defaultSearchString = "Restaurant"
    var businesses: [Business] = []

    /* Outlets */
    @IBOutlet weak var businessTableView: UITableView!
    var searchBar: UISearchBar!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide TableView initially
        businessTableView.hidden = true

        // Show loading spinner
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        businessTableView.delegate = self
        businessTableView.dataSource = self
        businessTableView.rowHeight = UITableViewAutomaticDimension
        self.searchBar = UISearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar

        // Do any additional setup after loading the view, typically from a nib.
        makeRequestWithParams(defaultSearchString)

        // Set navigation bar color
        var color: UIColor = UIColor(red: CGFloat(196/255.0), green: CGFloat(18/255.0), blue: CGFloat(0), alpha: CGFloat(1))
        navigationController?.navigationBar.barTintColor = color
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        // Update row heights when size of the device might be changing (orientation change)
        businessTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        businessTableView.reloadData()
    }
    
    @IBAction func handleTap(sender: AnyObject) {
        searchBar.endEditing(true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController.viewControllers![0] as FilterViewController
        destinationViewController.delegate = self
    }
    
    /* Filter Controller Methods */
    func test(msg: String) {
        println("HILL HILL HILL")
    }
    
    /* SearchBar Methods */
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text != "" {
            makeRequestWithParams(searchBar.text)
        }

        searchBar.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            makeRequestWithParams(defaultSearchString)
        }
    }

    /* TableView Methods */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = businessTableView.dequeueReusableCellWithIdentifier("businessInfo") as BusinessInfoCell

        cell.business = businesses[indexPath.row]
         
        return cell
    }
    
    /* Helpers */

    func makeRequestWithParams(searchTerm: String) -> Void {
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        var params = ["term": searchTerm, "location": "San Francisco"]

        client.searchWithTermAndOptions(searchTerm, options: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var businessDictionary = (response as NSDictionary)["businesses"] as [NSDictionary]
            self.businesses = businessDictionary.map({ (businessInfo: NSDictionary) -> Business in
                Business(business: businessInfo)
            })
            
            // Reload tableview
            self.businessTableView.reloadData()
            self.businessTableView.hidden = false
            // Hide Loading Spinner
             MBProgressHUD.hideHUDForView(self.view, animated: true)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
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
