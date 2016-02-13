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

class BusinessViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: BusinessDataSource!
    var currentSearchTask: NetTask?
    var progressDialog: MBProgressHUD!
    let defaultSearchTerm = "churrasco"
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        dataSource = BusinessDataSource(forTable: tableView)
        
        progressDialog = MBProgressHUD.showHUDAddedTo(tableView, animated: true)
        progressDialog.labelText = "Searching..."
        progressDialog.color = UIColor.redColor()
        
        
        searchBar.sizeToFit()
        searchBar.text = defaultSearchTerm
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        performSearch(defaultSearchTerm)
    }
    
    @IBAction func onTapOutside(sender: AnyObject) {
        searchBar.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performSearch(searchTerm: String) {
        currentSearchTask?.cancel()
        progressDialog.labelText = "Searching \(searchTerm)..."
        progressDialog.show(true)
        currentSearchTask = YelpService.sharedInstance.newRequest().searchTerm(searchTerm).execute(onSuccess: {
                result in
                    self.progressDialog.hide(true)
                    self.dataSource.items = result.businesses
            },
            onFailure: {
                self.progressDialog.hide(true)
                self.dataSource.items = []
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


}

