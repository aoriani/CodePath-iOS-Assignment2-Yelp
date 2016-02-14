//
//  FilterSectionControllers.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit

protocol FilterSectionControler {
    var tableView: UITableView? {get set}
    var sectionName:String {get}
    
    func applyStateFromRecipe(recipe: FilterRecipe)
    func numberOfItems() -> Int
    func getCellForPos(indexPath: NSIndexPath, switchDelegate: SettingsSwitchCellDelegate?) -> UITableViewCell
    
    // Those methods could be optional, but only Objective-C protocols support optionals
    // Swift structs are not compatible with Objective-C, so this has to be a pure Swift protocol
    func onTap(indexPath: NSIndexPath)
    func onSwitchChange(indexPath: NSIndexPath, isOn: Bool)
}

class DealsFilterController: FilterSectionControler {
    var tableView: UITableView?
    let sectionName = "Offers"
    
    //state 
    var hasDeals = false
    
    func applyStateFromRecipe(recipe: FilterRecipe) {
        hasDeals = recipe.deals
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func getCellForPos(indexPath: NSIndexPath, switchDelegate: SettingsSwitchCellDelegate?) -> UITableViewCell {
        let cell = tableView?.dequeueReusableCellWithIdentifier(SettingsSwitchCell.id, forIndexPath: indexPath) as! SettingsSwitchCell
        cell.populate(label: "Oferring a deal", isOn: hasDeals, switchDelegate: switchDelegate)
        return cell
    }
    
    func onTap(indexPath: NSIndexPath) {}
    
    func onSwitchChange(indexPath: NSIndexPath, isOn: Bool) {
        hasDeals = isOn
    }
}

class DistanceFilterController: FilterSectionControler {
    var tableView: UITableView?
    let sectionName = "Distance"
    
    //state
    var expanded = false
    var selectedDistance = YelpConsts.Distance.BestMatch
    
    func applyStateFromRecipe(recipe: FilterRecipe) {
        selectedDistance = recipe.distance
    }
    
    func numberOfItems() -> Int {
        return expanded ? YelpConsts.Distance.asArray.count : 1
    }
    
    func getCellForPos(indexPath: NSIndexPath, switchDelegate: SettingsSwitchCellDelegate?) -> UITableViewCell {
        let cell = tableView?.dequeueReusableCellWithIdentifier(SettingsDropDownCell.id, forIndexPath: indexPath) as! SettingsDropDownCell
        if !expanded {
            cell.populate(label: selectedDistance.toString(), state: SettingsDropDownCell.State.Collapsed)
        } else {
            let distance = YelpConsts.Distance.asArray[indexPath.row]
            let state = selectedDistance == distance ? SettingsDropDownCell.State.Checked : SettingsDropDownCell.State.Unchecked
            cell.populate(label: distance.toString(), state: state)
        }
        return cell
    }
    
    func onTap(indexPath: NSIndexPath) {
        if expanded {
            selectedDistance = YelpConsts.Distance.asArray[indexPath.row]
            expanded = false
        } else {
            expanded = true
        }
        tableView?.reloadData()
    }
    
    func onSwitchChange(indexPath: NSIndexPath, isOn: Bool) {}
}

class SortFilterController: FilterSectionControler {
    var tableView: UITableView?
    let sectionName = "Sort by"
    
    //state
    var expanded = false
    var selectedSort = YelpConsts.SortMode.BestMatched
    
    func applyStateFromRecipe(recipe: FilterRecipe) {
        selectedSort = recipe.sort
    }
    
    func numberOfItems() -> Int {
        return expanded ? YelpConsts.SortMode.asArray.count : 1
    }
    
    func getCellForPos(indexPath: NSIndexPath, switchDelegate: SettingsSwitchCellDelegate?) -> UITableViewCell {
        let cell = tableView?.dequeueReusableCellWithIdentifier(SettingsDropDownCell.id, forIndexPath: indexPath) as! SettingsDropDownCell
        if !expanded {
            cell.populate(label: selectedSort.toString(), state: SettingsDropDownCell.State.Collapsed)
        } else {
            let sort = YelpConsts.SortMode.asArray[indexPath.row]
            let state = selectedSort == sort ? SettingsDropDownCell.State.Checked : SettingsDropDownCell.State.Unchecked
            cell.populate(label: sort.toString(), state: state)
        }
        return cell
    }

    func onTap(indexPath: NSIndexPath) {
        if expanded {
            selectedSort = YelpConsts.SortMode.asArray[indexPath.row]
            expanded = false
        } else {
            expanded = true
        }
        tableView?.reloadData()
    }
    
    func onSwitchChange(indexPath: NSIndexPath, isOn: Bool){}
}


class CategoryFilterController: FilterSectionControler {
    var tableView: UITableView?
    let sectionName = "Categories"
    let minimumNumberOfVisibleCategories = 3
    
    //state
    var expanded = false
    var selectedCategories = Set<String>()
    
    func applyStateFromRecipe(recipe: FilterRecipe) {
        selectedCategories.removeAll()
        for category in recipe.categories {
            selectedCategories.insert(category)
        }
    }
    
    func numberOfItems() -> Int {
        // If not expanded we show the first 10 categories and a "See all" button
        return expanded ? YelpConsts.categoryDict.count : (minimumNumberOfVisibleCategories + 1)
    }
    
    private func isSeeAllCell(indexPath: NSIndexPath) -> Bool{
        let row = indexPath.row
        return !expanded && (row == minimumNumberOfVisibleCategories)
    }
    
    func getCellForPos(indexPath: NSIndexPath, switchDelegate: SettingsSwitchCellDelegate?) -> UITableViewCell {
        if isSeeAllCell(indexPath) {
            return (tableView?.dequeueReusableCellWithIdentifier("settingsSeeAll"))!
        } else {
            let cell = tableView?.dequeueReusableCellWithIdentifier(SettingsSwitchCell.id, forIndexPath: indexPath) as! SettingsSwitchCell
            let row = indexPath.row
            let categoryLabel = YelpConsts.categoryLabels[row]
            let isOn = selectedCategories.contains(YelpConsts.categoryKeys[row])
            cell.populate(label: categoryLabel, isOn: isOn, switchDelegate: switchDelegate)
            return cell
        }
    }
    
    func onTap(indexPath: NSIndexPath) {
        if isSeeAllCell(indexPath) {
            expanded = true
            tableView?.reloadData()
        }
    }
    
    func onSwitchChange(indexPath: NSIndexPath, isOn: Bool) {
        let category = YelpConsts.categoryKeys[indexPath.row]
        if isOn {
            selectedCategories.insert(category)
        } else {
            selectedCategories.remove(category)
        }
        print("Category: \(category) Value: \(isOn)")
    }
}
