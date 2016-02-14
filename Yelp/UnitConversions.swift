//
//  UnitConversions.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation


func toMiles(fromMeters meters:NSDecimalNumber) -> NSDecimalNumber {
    return meters.decimalNumberByMultiplyingBy(0.000621371)
}

func toMeters(fromMiles miles:NSDecimalNumber) -> NSDecimalNumber {
    return miles.decimalNumberByMultiplyingBy(1609.34)
}