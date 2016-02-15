//
//  SearchResult.swift
//  Yelp
//
//  Created by Andre Oriani on 2/11/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import ELCodable

struct Coordinates: Decodable {
    var latitude: Decimal
    var longitude: Decimal
    
    static func decode(json: JSON?) throws -> Coordinates {
        return try Coordinates(
            latitude: json ==> "latitude",
            longitude: json ==> "longitude"
        )
    }
}

struct Location: Decodable {
    var address: [String]
    var city: String
    var state: String
    var zipCode: String
    var coordinates: Coordinates
    
    static func decode(json: JSON?) throws -> Location {
        return try Location(
            address: json ==> "address",
            city: json ==> "city",
            state: json ==> "state_code",
            zipCode: json ==> "postal_code",
            coordinates: json ==> "coordinate"
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
    var mobile_url: String
    var location: Location
    var phoneNumber: String?
    var snippetImageURL: String
    var snippetText: String
    
    var distanceMiles:NSDecimalNumber? {
        return distanceMeters != nil ? toMiles(fromMeters: distanceMeters!.value): nil
    }

    static func decode(json: JSON?) throws -> Business {
        return try Business(
            name: json ==> "name",
            imageUrl: json ==> "image_url",
            reviewCount: json ==> "review_count",
            ratingImageURL: json ==> "rating_img_url_large",
            distanceMeters: json ==> "distance",
            categories: manuallyDecodeCategories(json!),
            mobile_url: json ==> "mobile_url",
            location: json ==> "location",
            phoneNumber: json ==> "display_phone",
            snippetImageURL:json ==> "snippet_image_url",
            snippetText: json ==> "snippet_text"
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
