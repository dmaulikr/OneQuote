//
//  FlickerClient.swift
//  Virutal Tourist
//
//  Created by Ryan Phan on 6/12/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import Foundation
import MapKit

class FlickerClient: NSObject {

    class func searchForWallpaper( handler: @escaping (_ data: [String])-> Void) {
  
            let methodParameters: [String: String] = [Constants.FlickrParameterKeys.Method:Constants.FlickrParameterValues.SearchMethod,
                                                      Constants.FlickrParameterKeys.APIKey:Constants.FlickrParameterValues.APIKey,
                                                      Constants.FlickrParameterKeys.SafeSearch:Constants.FlickrParameterValues.UseSafeSearch,
                                                      Constants.FlickrParameterKeys.Extras:Constants.FlickrParameterValues.MediumURL,
                                                      Constants.FlickrParameterKeys.Format:Constants.FlickrParameterValues.ResponseFormat,
                                                      Constants.FlickrParameterKeys.NoJSONCallback:Constants.FlickrParameterValues.DisableJSONCallback,
                                                      Constants.FlickrParameterKeys.PerPage:Constants.FlickrParameterValues.NumberOfImagePerPage,
                                                      Constants.FlickrParameterKeys.Tags: Constants.FlickrParameterValues.InspireSunRiseTag]
            
            getImageFromFlickrBySearch(methodParameters as [String: AnyObject]) { (data) in
                DispatchQueue.main.async {
                    handler(data)
            }
                
            
        }
   
       
    }


    class func getImageFromFlickrBySearch(_ methodParameters: [String: AnyObject], handler: @escaping (_ arrayOfImageURLs: [String])-> Void) {
        
        // TODO: Make request to Flickr!
        
        let session = URLSession.shared
        let request = URLRequest(url: flickrURLFromParameters(methodParameters))
        DispatchQueue.global(qos: .userInteractive).async {
            let task =  session.dataTask(with: request) { (data, response, error)  in
                var arrayOfImageURLs = [String]()
                var jsonObject: [String:AnyObject]
                if error == nil {
                    do {
                        jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                        if let photosObject = jsonObject["photos"] as? [String: AnyObject] {
                            if let photoArray = photosObject["photo"] as? [AnyObject] {
                                for photo in photoArray {
                                    if let photoURL = photo["url_m"] as? String{
                                        arrayOfImageURLs.append(photoURL)
                                    }
                                }
                                DispatchQueue.main.async {
                                    handler(arrayOfImageURLs)
                                }
                               
                            }
                            
                        }
                    }
                    catch {
                        print("Could not parse data as JSON")
                    }
                }
                else {
                    print(error!.localizedDescription)
                }
            }
            task.resume()
            
        }
    }
    class func flickrURLFromParameters(_ parameters: [String: AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }



}
