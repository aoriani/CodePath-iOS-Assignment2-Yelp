//
//  FilterDataSource.swift
//  Yelp
//
//  Created by Andre Oriani on 2/14/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit


class FilterDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView
    private let filterControllers: [FilterSectionControler]
    
    init(forTable tableView: UITableView) {
        self.tableView = tableView
        filterControllers = [DealsFilterController(), DistanceFilterController(), SortFilterController(), CategoryFilterController()]
        super.init()
        
        for var filterController in filterControllers {
            filterController.tableView = self.tableView
        }
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterControllers.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterControllers[section].sectionName
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterControllers[section].numberOfItems()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return filterControllers[indexPath.section].getCellForPos(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        filterControllers[indexPath.section].onTap(indexPath)
    }

}
