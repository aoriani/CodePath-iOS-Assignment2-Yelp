//
//  YelpService.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//  Copyright © 2016 Orion. All rights reserved.
//

import AFNetworking
import BDBOAuth1Manager
import ELCodable

typealias NetTask = AFHTTPRequestOperation

class YelpService: BDBOAuth1RequestOperationManager {
    
    enum SortMode: Int {
        case BestMatched = 0, Distance, HighestRated
    }
    
    class RequestBuilder {
        private var parameters = [String : AnyObject]()
        private init() {
            //Location is required, setting default to SF
            let lastKnowLocation = LocationManager.sharedInstance.getLastKnownLocation()
            parameters["ll"] = String(format: "%0.6f,%0.6f", lastKnowLocation.lat, lastKnowLocation.lon)
        }
        
        func searchTerm(term: String) -> RequestBuilder {
            if !term.isEmpty {
             parameters["term"] = term
            }
            return self
        }
        
        func sort(mode: SortMode) -> RequestBuilder {
            parameters["sort"] = mode.rawValue
            return self
        }
        
        func hasDeals(has: Bool) -> RequestBuilder {
            parameters["deals_filter"] = has
            return self
        }
        
        func categories(categories: [String]) -> RequestBuilder {
            if categories.count > 0 {
                parameters["category_filter"] = categories.joinWithSeparator(",")
            }
            return self
        }
        
        func limit(limit: UInt) -> RequestBuilder {
            parameters["limit"] = limit
            return self
        }
        
        func offset(offset: UInt) -> RequestBuilder {
            parameters["offset"] = offset
            return self
        }
        
        func radiusMeter(radius: UInt) -> RequestBuilder {
            parameters["radius_filter"] = radius
            return self
        }
        
        func execute(onSuccess onSuccess: (SearchResults) -> Void, onFailure: () -> Void = {}) -> NetTask {
            return YelpService.sharedInstance.doRequest(self, onSuccess: onSuccess, onFailure: onFailure)
        }
        
    }
    
    
    //OAuth 1
    private static let consumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    private static let consumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    private static let accessToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    private static let accessSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    private static let baseUrl = NSURL(string: "https://api.yelp.com/v2/")
    
    //Thread safe singleton in Swift 2 (http://krakendev.io/blog/the-right-way-to-write-a-singleton)
    static let sharedInstance = YelpService()
    
    private init() {
        super.init(baseURL: YelpService.baseUrl, consumerKey: YelpService.consumerKey, consumerSecret: YelpService.consumerSecret)
        let token = BDBOAuth1Credential(token: YelpService.accessToken, secret: YelpService.accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func newRequest() -> RequestBuilder {
        return RequestBuilder()
    }

    private func doRequest(request: RequestBuilder, onSuccess: (SearchResults) -> Void, onFailure: () -> Void) -> NetTask {
        return GET("search", parameters: request.parameters,
            success: { (_ , response) in
                do {
                    let json = JSON(response)
                    let result = try SearchResults.decode(json)
                    onSuccess(result)
                } catch {
                    onFailure()
                }
            },
            failure:{ (operation: AFHTTPRequestOperation?, error: NSError!) -> Void in onFailure()})!
    }
}
