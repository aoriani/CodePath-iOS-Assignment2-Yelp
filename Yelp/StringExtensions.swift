//
//  StringExtensions.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation

extension String {
    func contains(aString: String) -> Bool {
        return self.lowercaseString.rangeOfString(aString.lowercaseString) != nil
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}