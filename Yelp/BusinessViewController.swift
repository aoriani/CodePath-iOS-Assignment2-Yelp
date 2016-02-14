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

class BusinessViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: BusinessDataSource!
    var currentSearchTask: NetTask?
    let defaultSearchTerm = "churrasco"
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        dataSource = BusinessDataSource(forTable: tableView)
        
    
        searchBar.sizeToFit()
        searchBar.text = defaultSearchTerm
        searchBar.placeholder = "e.g. Gnocchi, delivery, TGI Fridays"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        performSearch(defaultSearchTerm)
    }
    
    @IBAction func onTapOutside(sender: AnyObject) {
        searchBar.resignFirstResponder()
    }
    
    func performSearch(searchTerm: String) {
        currentSearchTask?.cancel()
        let progressDialog = MBProgressHUD.showHUDAddedTo(topView, animated: true)
        progressDialog.color = UIColor.redColor()
        progressDialog.labelText = "Searching \(searchTerm)..."
        progressDialog.show(true)
        currentSearchTask = YelpService.sharedInstance.newRequest().searchTerm(searchTerm).execute(onSuccess: {
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
                performSearch(searchTerm)
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

