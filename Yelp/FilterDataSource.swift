//
//  FilterDataSource.swift
//  Yelp
//
//  Created by Andre Oriani on 2/14/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit

class FilterDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, SettingsSwitchCellDelegate {
    private let tableView: UITableView
    private let filterControllers: [FilterSectionControler]
    private let dealsFilter = DealsFilterController()
    private let distanceFilter = DistanceFilterController()
    private let sortFilter = SortFilterController()
    private let categoryFilter = CategoryFilterController()
    

    init(forTable tableView: UITableView, withInitialFilter filterRecipe: FilterRecipe) {
        self.tableView = tableView
        filterControllers = [dealsFilter, distanceFilter, sortFilter, categoryFilter]
        super.init()
        
        for var filterController in filterControllers {
            filterController.tableView = self.tableView
            filterController.applyStateFromRecipe(filterRecipe)
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
        return filterControllers[indexPath.section].getCellForPos(indexPath, switchDelegate: self)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        filterControllers[indexPath.section].onTap(indexPath)
    }
    
    func settingsSwitchCell(settingsSwitchCell: SettingsSwitchCell, didChangeValue: Bool) {
        if let indexPath = tableView.indexPathForCell(settingsSwitchCell) {
            filterControllers[indexPath.section].onSwitchChange(indexPath, isOn: didChangeValue)
        }
    }
    
    func getFilterRecipe() -> FilterRecipe {
        let deals = dealsFilter.hasDeals
        let distance = distanceFilter.selectedDistance
        let sort = sortFilter.selectedSort
        let categories = Array<String>(categoryFilter.selectedCategories)
        
        return FilterRecipe(deals: deals, distance: distance, sort: sort, categories: categories)
    }

}
