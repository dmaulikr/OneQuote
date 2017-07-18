//
//  ViewController.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/9/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import UIKit
import CoreData
class OneQuoteViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var quoteLabel: UILabel!
    var wallpaper: Wallpaper?
    var colorGenerator = ColorWheel()
    var quote:String? {
        didSet {
            UserDefaults.standard.set(quote, forKey:"currentQuote")
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activitySpinner.hidesWhenStopped = true
        view.backgroundColor = colorGenerator.getRandomColor()
        wallpaper = Wallpaper()
       
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        if let currentQuote = UserDefaults.standard.value(forKey: "currentQuote") as? String {
            quoteLabel.text = currentQuote
            quote = currentQuote
        }

        
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
        OneQuoteClient.sharedInstance().getMethod(method, parameters: parameters) { [weak self] (result, error) in
            if let errorMessage = error {
                DispatchQueue.main.async {
                    self?.displayErrorMessage(errorMessage)
                }
                
            }
            if let parsedData = result as? [String: AnyObject]{
                if let errorCode = parsedData["error"] as? [String:AnyObject]  {
                    DispatchQueue.main.async {
                        if let code = errorCode["code"] as? Int, let message = errorCode["message"] as? String {
                            let errorMessage =  OneQuoteClient.CustomError(localizedDescription: "\(code): \(message)")
                            self?.displayErrorMessage(errorMessage)
                        }
                    }
                    
            }
                
            if let contents = parsedData["contents"] as? [String:AnyObject] {
                    if let quote = contents["quote"] as? String, let author = contents["author"] as? String, let id = contents["id"] as? String {
                        DispatchQueue.main.async {
                            self?.quote = "\(quote) - \(author)"
                            self?.quoteLabel.text = self?.quote
                            let color = self?.colorGenerator.getRandomColor()
                            self?.view.backgroundColor = color
                            self?.quoteLabel.backgroundColor = color
                            
                            if (self?.wallpaper?.wallpapers.isEmpty != true) {
                                let imageURL = self?.wallpaper?.getRandomPicURL()
                                DispatchQueue.global(qos: .userInteractive).async {
                                    
                                    if let url = URL(string: imageURL!) {
                                        do {
                                            let data = try Data(contentsOf: url)
                                            
                                            DispatchQueue.main.async {
                                                let image = UIImage(data: data)
                                                self?.imageView.image = image
                                            }
                                            
                                        }
                                        catch {
                                            print("Error getting Data")
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            self?.activitySpinner.stopAnimating()
                            self?.persistQuote(quote, id: id, author: author)
                            
                            
                        }
                        
                    }
                }
            }
        }
        
    }
    func persistQuote(_ quote:String, id:String, author:String ) {
        AppDelegate.persistentContainer.performBackgroundTask { (context) in
            let _ = Quote(context: context, author: author, id: id, quote: quote, date: Date())
            try? context.save()
        }
//    printDBStatistic()
    }
    func displayErrorMessage(_ error: Error) {
            let alertVC = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: false, completion: nil  )
            activitySpinner.stopAnimating()
        
    }
    func printDBStatistic () {
        let context = AppDelegate.viewContext
        context.perform {
            let request: NSFetchRequest<Quote> = Quote.fetchRequest()
            
            if let result = try? context.fetch(request) {
                print("Count: \(result.count)")
                
                for quote in result {
                    print("Quote: \(String(describing: quote.quote))\n Author:\(String(describing: quote.author))\n Id:\(String(describing: quote.id))")
                }
            }
        }
    
    }

    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: [quote], applicationActivities: nil )
        activityViewController.excludedActivityTypes = [UIActivityType.postToFacebook]
        present(activityViewController, animated: true, completion: nil)
    }

}

