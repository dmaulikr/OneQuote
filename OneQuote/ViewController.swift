//
//  ViewController.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/9/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

    @IBAction func getPressed(_ sender: UIButton) {
        var parameters = [String: AnyObject]()
        parameters["category"] = "inspire" as AnyObject
//        parameters["maxlength"] = "100" as AnyObject
        
        OneQuoteClient.sharedInstance().getMethod(Constants.Methods.Search, parameters: parameters) { (result) in
            
        }
    }


}

