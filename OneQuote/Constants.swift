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
        static let Management = "management"
        static let Life = "life"
        static let Funny = "funny"
        static let MaxLengthValue = "130"
        static let MinLengthValue = "20"
    }

    // MARK: Flickr
    struct Flickr {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
        
        static let SearchBBoxHalfWidth = 1.0
        static let SearchBBoxHalfHeight = 1.0
        static let SearchLatRange = (-90.0, 90.0)
        static let SearchLonRange = (-180.0, 180.0)
    }
    
    // MARK: Flickr Parameter Keys
    struct FlickrParameterKeys {
        static let Method = "method"
        static let APIKey = "api_key"
        static let GalleryID = "gallery_id"
        static let Extras = "extras"
        static let Format = "format"
        static let NoJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let Text = "text"
        static let BoundingBox = "bbox"
        static let Page = "page"
        static let PerPage = "per_page"
        static let Tags = "tags"
    }
    
    // MARK: Flickr Parameter Values
    struct FlickrParameterValues {
        static let SearchMethod = "flickr.photos.search"
        static let APIKey = "a5f4e43a23f8074db0e11030c340ea0f"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1" /* 1 means "yes" */
        static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
        static let GalleryID = "5704-72157622566655097"
        static let MediumURL = "url_m"
        static let UseSafeSearch = "1"
        static let NumberOfImagePerPage = "1000"
        static let InspireSunRiseTag = "sunrise"
    }
    
    // MARK: Flickr Response Keys
    struct FlickrResponseKeys {
        static let Status = "stat"
        static let Photos = "photos"
        static let Photo = "photo"
        static let Title = "title"
        static let MediumURL = "url_m"
        static let Pages = "pages"
        static let Total = "total"
    }
    
    // MARK: Flickr Response Values
    struct FlickrResponseValues {
        static let OKStatus = "ok"
    }


    

}
