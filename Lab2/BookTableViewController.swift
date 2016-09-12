//
//  BookTableViewController.swift
//  Lab2
//
//  Created by Hui Shen on 09/11/2016.
//  Copyright © 2016 Hui. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    // MARK: Properties
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
               navigationItem.leftBarButtonItem = editButtonItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.simpleBookManager.books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BookTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        
        // Fetches the appropriate book for the data source layout.
        let book = appDelegate.simpleBookManager.books[indexPath.row]
        
        cell.titleLabel.text = book.title
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            appDelegate.simpleBookManager.books.removeAtIndex(indexPath.row)
            appDelegate.simpleBookManager.saveChanges()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let bookDetailViewController = segue.destinationViewController as! BookDetailViewController
            
            // Get the cell that generated this segue.
            if let selectedBookCell = sender as? BookTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedBookCell)!
                let selectedBook = appDelegate.simpleBookManager.books[indexPath.row]
                bookDetailViewController.book = selectedBook
            }
        }
        else if segue.identifier == "AddBook" {
            print("Adding new book.")
        }
    }
    

    @IBAction func unwindToBookList(sender: UIStoryboardSegue) {
        
        
        if let sourceViewController = sender.sourceViewController as? BookViewController, book = sourceViewController.book {
            // Add a new book item.
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                appDelegate.simpleBookManager.books[selectedIndexPath.row] = book
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }else {
                // Add a new book.
                let newIndexPath = NSIndexPath(forRow: appDelegate.simpleBookManager.books.count, inSection: 0)
                appDelegate.simpleBookManager.books.append(book)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            appDelegate.simpleBookManager.saveChanges()
            print(String( appDelegate.simpleBookManager.books.count))

        }
    }

}
