//
//  OneQuoteClient.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/9/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import Foundation

class OneQuoteClient: NSObject {
    var session = URLSession.shared
    
    // create a URL from parameters
    private func oneQuoteURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.OneQuote.APIScheme
        components.host = Constants.OneQuote.APIHost
        components.path = Constants.OneQuote.APIPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    class func sharedInstance() -> OneQuoteClient {
        struct Singelton {
            static var sharedInstance = OneQuoteClient()
        }
        return Singelton.sharedInstance
    }
}
