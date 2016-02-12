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
    var items:[Business] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(forTable tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: No results cell
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: No results cell
        let cell = tableView.dequeueReusableCellWithIdentifier("businessCell", forIndexPath: indexPath) as! BusinessTableCell
        cell.populate(items[indexPath.row])
        return cell
    }
}