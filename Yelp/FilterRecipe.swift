//
//  FilterRecipe.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation

// Imutable active filter representation to be passed around
struct FilterRecipe {
    let deals: Bool
    let sort: YelpConsts.SortMode
    let distance: YelpConsts.Distance
    let categories: [String]
    
    func apply(toRequest request: YelpService.RequestBuilder) {
        request.hasDeals(deals)
        request.radiusMeter(distance.meters())
        request.sort(sort)
        request.categories(categories)
    }
}