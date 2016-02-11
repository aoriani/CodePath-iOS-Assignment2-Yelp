//
//  SearchResult.swift
//  Yelp
//
//  Created by Andre Oriani on 2/11/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import ELCodable

struct Business: Decodable {
    var name: String
    
    
    
    static func decode(json: JSON?) throws -> Business {
        return try Business(
            name: json ==> "name"
        )
    }
}

struct QueryResult: Decodable {
    var total:Int
    var businesses: [Business]
    
    
    static func decode(json: JSON?) throws -> QueryResult {
        return try QueryResult(
            total: json ==> "total",
            businesses: json ==> "businesses"
        )
    }
}
