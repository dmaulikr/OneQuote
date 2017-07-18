//
//  CreateQuoteViewController.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/17/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import UIKit
import CoreData

class CreateQuoteViewController: UIViewController, UITextFieldDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    var completeQuote:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteTextField.delegate = self
        authorTextField.delegate = self
        self.tabBarController?.delegate = self
    }

    
    @IBAction func submitPressed(_ sender: UIButton) {
        if let quote = quoteTextField.text , let author = authorTextField.text {
                let randomStringGenerator = RandomString()
                let id = randomStringGenerator.randomString(length: 24)
                completeQuote = "\(quote) - \(author)"
                AppDelegate.persistentContainer.performBackgroundTask { (context) in
                    let _ = Quote(context: context, author: author, id: id, quote: quote, date: Date())
                    try? context.save()
                }
                quoteTextField.text = ""
                authorTextField.text = ""
                quoteTextField.resignFirstResponder()
                authorTextField.resignFirstResponder()
        
                if let oneQuoteVC = self.tabBarController?.viewControllers?[0].childViewControllers[0] as? OneQuoteViewController {
                    oneQuoteVC.quote = completeQuote
                }
                self.tabBarController?.selectedIndex = 0

        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        quoteTextField.resignFirstResponder()
        authorTextField.resignFirstResponder()
        return false
    }


    
}
