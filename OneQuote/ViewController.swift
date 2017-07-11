//
//  ViewController.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/9/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var quoteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activitySpinner.hidesWhenStopped = true
       
    }


    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        var parameters = [String: AnyObject]()
        parameters[Constants.ParameterKey.Category] = Constants.ParameterValue.Inspire as AnyObject
        parameters[Constants.ParameterKey.MaxLength] = Constants.ParameterValue.MaxLengthValue as AnyObject
        parameters[Constants.ParameterKey.MinLength] = Constants.ParameterValue.MinLengthValue as AnyObject
        
        activitySpinner.startAnimating()
        OneQuoteClient.sharedInstance().getMethod(Constants.Methods.Search, parameters: parameters) { (result, error) in
            if let parsedData = result as? [String: AnyObject]{
                if let contents = parsedData["contents"] as? [String:AnyObject] {
                    if let quote = contents["quote"] as? String, let author = contents["author"] as? String {
                        DispatchQueue.main.async {
                            self.activitySpinner.stopAnimating()
                            self.quoteLabel.text = "\(quote) - \(author)"
                        }
                        
                    }
                }
            }
        }
    }


}

