//
//  Constants.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/9/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import Foundation


struct Constants {
    
    // MARK: Flickr
    struct OneQuote {
        static let APIScheme = "http"
        static let APIHost = "quotes.rest"
        static let APIPath = "/quote"
        static let APIKey = "sObr2wHt6bv8PEwu0e3rLQeF"
        
    }
    struct Methods {
    
        static let Search = "/search"
        static let Random = "/random"
    }
    
    struct ParameterKey {
        static let RequestHeaderSecret = "X-TheySaidSo-Api-Secret"
        static let Category = "category"
        static let MaxLength = "maxlength"
        static let MinLength = "minlength"
    }
    struct ParameterValue{
        static let Inspire = "inspire"
        static let MaxLengthValue = "300"
        static let MinLengthValue = "100"
    }


    

}
