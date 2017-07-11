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
    
    func getMethod (_ method: String, parameters: [String: AnyObject], completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        //1. Set parameters
        
        //2. Build the URL
        let url = oneQuoteURLFromParameters(parameters, withPathExtension: method)
        
        //3. Configure the request
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue( Constants.OneQuote.APIKey, forHTTPHeaderField:Constants.ParameterKey.RequestHeaderSecret )
        
        
        //4. Make the request
        DispatchQueue.global(qos: .userInteractive).async {
            let task = self.session.dataTask(with: request as URLRequest) { (data, response, error) in
                //5. and 6. Parse and use the data
                
                /* GUARD: Was there any data returned? */
                guard let data = data else {
                    print("No data was returned by the request!")
                    return
                }
                DispatchQueue.main.async {
                    self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
                }
                
            }
            //7. Start the request
            task.resume()

        }
        print("URL:\(url)")
    }
    
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
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            print("Result: \(parsedResult)")
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        DispatchQueue.main.async {
            completionHandlerForConvertData(parsedResult, nil)
        }
        
    }
    
    class func sharedInstance() -> OneQuoteClient {
        struct Singelton {
            static var sharedInstance = OneQuoteClient()
        }
        return Singelton.sharedInstance
    }
}
