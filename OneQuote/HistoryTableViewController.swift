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
        request.sortDescriptors = [NSSortDescriptor(key: "quote", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
        fetchResultsController = NSFetchedResultsController<Quote>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        try? fetchResultsController?.performFetch()
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath)
        
        if let quote = fetchResultsController?.object(at: indexPath){
            cell.textLabel?.text = quote.quote
            cell.detailTextLabel?.text = quote.author
//            cell.tintColor = UIColor.blue
        }

        return cell
    }
    @IBAction func refresh(_ sender: UIRefreshControl) {
        retrieveDataFromDB()
        self.refreshControl?.endRefreshing()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
