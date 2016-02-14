//
//  FilterViewController.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filterViewController(filterViewController: FilterViewController, didFilterChange: FilterRecipe)
}

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var filterDataSource: FilterDataSource!
    var delegate: FilterViewControllerDelegate?
    var filterRecipe:FilterRecipe = FilterRecipe.emptyFilter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        filterDataSource = FilterDataSource(forTable: tableView, withInitialFilter: filterRecipe)
    }


    @IBAction func onCancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.filterViewController(self, didFilterChange: filterDataSource.getFilterRecipe())
    }
}
