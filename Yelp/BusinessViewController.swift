//
//  ViewController.swift
//  Yelp
//
//  Created by Andre Oriani on 2/10/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD

class BusinessViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, FilterViewControllerDelegate {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    
    var dataSource: BusinessDataSource!
    var currentSearchTask: NetTask?
    var filterRecipe = FilterRecipe.emptyFilter
    var searchTerm = "churrasco"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        dataSource = BusinessDataSource(forTable: tableView)
        
    
        searchBar.sizeToFit()
        searchBar.text = searchTerm
        searchBar.placeholder = "e.g. Gnocchi, delivery, TGI Fridays"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        performSearch()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTapOutside(sender: AnyObject) {
        searchBar.resignFirstResponder()
    }
    
    func performSearch() {
        currentSearchTask?.cancel()
        let progressDialog = MBProgressHUD.showHUDAddedTo(topView, animated: true)
        progressDialog.color = UIColor.redColor()
        progressDialog.labelText = "Searching \(searchTerm)..."
        progressDialog.show(true)
        currentSearchTask = YelpService.sharedInstance.newRequest().searchTerm(searchTerm).filters(filterRecipe).execute(onSuccess: {
                result in
                    progressDialog.hide(true)
                    self.dataSource.setItems(result.businesses)
            },
            onFailure: {
                progressDialog.hide(true)
                self.dataSource.setItems([])
            }
        )
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTermFull = searchBar.text {
            let searchTerm = searchTermFull.trim()
            if !searchTerm.isEmpty {
                self.searchTerm = searchTerm
                performSearch()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func filterViewController(filterViewController: FilterViewController, didFilterChange: FilterRecipe) {
        self.filterRecipe = didFilterChange
        performSearch()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "filterRoute" {
                let navController = segue.destinationViewController as! UINavigationController
                let filtersViewController = navController.topViewController as! FilterViewController
                filtersViewController.delegate = self
                filtersViewController.filterRecipe = filterRecipe
            } else if segueIdentifier == "businessDetailsRoute" {
                let cell = sender as! UITableViewCell
                let indexPath = tableView.indexPathForCell(cell)!
                let selectedBusiness = dataSource.getItem(indexPath.row)
                let detailController = segue.destinationViewController as! BusinessDetailsViewController
                detailController.business = selectedBusiness
            }
        }
    }

}

