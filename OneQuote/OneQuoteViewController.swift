//
//  ViewController.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/9/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import UIKit

class OneQuoteViewController: UIViewController {


    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var quoteLabel: UILabel!
    var colorGenerator = ColorWheel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activitySpinner.hidesWhenStopped = true
        view.backgroundColor = colorGenerator.getRandomColor()

    }


    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        var parameters = [String: AnyObject] ()
        parameters[Constants.ParameterKey.Category] = Constants.ParameterValue.Inspire as AnyObject
        parameters[Constants.ParameterKey.MaxLength] = Constants.ParameterValue.MaxLengthValue as AnyObject
        parameters[Constants.ParameterKey.MinLength] = Constants.ParameterValue.MinLengthValue as AnyObject
        getQuoteWithParameters(parameters, method: Constants.Methods.Search)
    }
    @IBAction func swipeRecognized(_ sender: UISwipeGestureRecognizer) {
        let parameters = [String: AnyObject] ()
        getQuoteWithParameters(parameters, method: Constants.Methods.Random)
    }

    func getQuoteWithParameters (_ parameters: [String:AnyObject], method: String) {

        activitySpinner.startAnimating()
        OneQuoteClient.sharedInstance().getMethod(method, parameters: parameters) { (result, error) in
            if let parsedData = result as? [String: AnyObject]{
                if let contents = parsedData["contents"] as? [String:AnyObject] {
                    if let quote = contents["quote"] as? String, let author = contents["author"] as? String {
                        DispatchQueue.main.async {
                            self.quoteLabel.text = "\(quote) - \(author)"
                            self.view.backgroundColor = self.colorGenerator.getRandomColor()
                            self.activitySpinner.stopAnimating()
                        }
                        
                    }
                }
            }
        }
    }

}
