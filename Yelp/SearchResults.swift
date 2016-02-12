//
//  SearchResult.swift
//  Yelp
//
//  Created by Andre Oriani on 2/11/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import ELCodable

struct Location: Decodable {
    var address: [String]
    var city: String
    var state: String
    var zipCode: String
    
    static func decode(json: JSON?) throws -> Location {
        return try Location(
            address: json ==> "address",
            city: json ==> "city",
            state: json ==> "state_code",
            zipCode: json ==> "postal_code"
        )
    }
}

struct Business: Decodable {
    var name: String
    var imageUrl: String
    var reviewCount: Int
    var ratingImageURL: String
    var distanceMeters: Decimal?
    var categories: String
    var location: Location
    
    var distanceMiles:NSDecimalNumber? {
        return distanceMeters != nil ? distanceMeters!.value.decimalNumberByMultiplyingBy(0.000621371): nil
    }

    static func decode(json: JSON?) throws -> Business {
        return try Business(
            name: json ==> "name",
            imageUrl: json ==> "image_url",
            reviewCount: json ==> "review_count",
            ratingImageURL: json ==> "rating_img_url_large",
            distanceMeters: json ==> "distance",
            categories: manuallyDecodeCategories(json!),
            location: json ==> "location"
        )
    }
    
    static func manuallyDecodeCategories(json: JSON) -> String {
        // ELCodable has some trouble with array of arrays.
        // My current expertise on swift doesn't allow me to do a fix for the library.
        // I barely remember operator overloading in C++ : )
        // So let's get back to the dictionary based approach
        var result = "No categories"
        if let dictionary = json.object as! NSDictionary? {
            if let categoriesArray = dictionary["categories"] as? [[String]] {
                var categoryNames = [String]()
                for category in categoriesArray {
                    let categoryName = category[0]
                    categoryNames.append(categoryName)
                }
                result = categoryNames.joinWithSeparator(", ")
            }
        }
        return result
    }
}

struct SearchResults: Decodable {
    var total:Int
    var businesses: [Business]
    
    
    static func decode(json: JSON?) throws -> SearchResults {
        return try SearchResults(
            total: json ==> "total",
            businesses: json ==> "businesses"
        )
    }
}
