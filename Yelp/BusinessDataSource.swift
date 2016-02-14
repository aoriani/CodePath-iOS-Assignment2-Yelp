//
//  DataSource.swift
//  Yelp
//
//  Created by Andre Oriani on 2/11/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit

class BusinessDataSource:NSObject, UITableViewDataSource {
    
    private var tableView: UITableView
    private var items:[Business] = []
    private var wasDataSourceSet = false
    
    init(forTable tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
    
    func setItems(items: [Business]) {
        if (!wasDataSourceSet) {
            // Delay setting the datasource so we don't show the 
            // "No results" cell prior to the first query
            self.tableView.dataSource = self
            wasDataSourceSet = true
        }
        
        self.items = items
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 1: items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (!items.isEmpty) {
            let cell = tableView.dequeueReusableCellWithIdentifier("businessCell", forIndexPath: indexPath) as! BusinessTableCell
            cell.populate(items[indexPath.row])
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier("emptyErrorCell")!
        }
    }
}