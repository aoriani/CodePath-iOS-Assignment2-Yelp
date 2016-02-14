//
//  FilterViewController.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var filterDataSource: FilterDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        filterDataSource = FilterDataSource(forTable: tableView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onCancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
