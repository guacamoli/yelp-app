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

class FilterViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var delegate: YelpFiltersDelegate?  = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.test("sahil")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
//        test("no")
    }
    
    @IBAction func onCancelClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
