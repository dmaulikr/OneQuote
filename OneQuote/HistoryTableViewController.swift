//
//  HistoryTableViewController.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/16/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {
    var fetchResultsController:NSFetchedResultsController<Quote>?
    var completeQuote:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDataFromDB()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveDataFromDB()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchResultsController?.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func retrieveDataFromDB () {
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Quote> = Quote.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
        fetchResultsController = NSFetchedResultsController<Quote>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        try? fetchResultsController?.performFetch()
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath)
        
        if let quote = fetchResultsController?.object(at: indexPath){
            cell.textLabel?.text = quote.quote
            cell.detailTextLabel?.text = quote.author
            cell.imageView?.image = UIImage(named: "quote")

        }

        return cell
    }
    @IBAction func refresh(_ sender: UIRefreshControl) {
        retrieveDataFromDB()
        self.refreshControl?.endRefreshing()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let quote = fetchResultsController?.object(at: indexPath), let quoteString = quote.quote, let quoteAuthor = quote.author{
            completeQuote = quoteString + " - " + quoteAuthor
            performSegue(withIdentifier: "showQuote", sender: self)
         
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "showQuote" {
                if let oneQuoteVC = segue.destination as? OneQuoteViewController {
                    oneQuoteVC.quote = completeQuote
                    UserDefaults.standard.set(completeQuote, forKey:"currentQuote")
                }
            }
            
        }
    }
 

}
