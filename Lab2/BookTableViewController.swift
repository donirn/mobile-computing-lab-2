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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               navigationItem.leftBarButtonItem = editButtonItem()
        let bgImage = UIImage(named: "subtle_white_feathers")
        navigationController?.navigationBar.setBackgroundImage(bgImage, forBarMetrics: .Default)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SimpleBookManager.sharedInstance.books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BookTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        
        // Fetches the appropriate book for the data source layout.
        let book = SimpleBookManager.sharedInstance.books[indexPath.row]
        
        cell.titleLabel.text = book.title
        cell.authorLabel.text = "by \(book.author)"
        cell.priceLabel.text = "\(book.price) SEK"
        cell.coverImageView.image = nil
        
        cell.tag = Int(book.isbn)!
        cell.coverImageView.getImage(book.isbn, link: book.coverLink) { (image) in
            guard cell.tag == Int(book.isbn) else {return}
            dispatch_async(dispatch_get_main_queue(), {
                cell.coverImageView.image = image
            })
        }
        
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        SimpleBookManager.sharedInstance.moveBookAtIndex(fromIndexPath.row, toIndex: toIndexPath.row)
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            SimpleBookManager.sharedInstance.books.removeAtIndex(indexPath.row)
            SimpleBookManager.sharedInstance.saveChanges()
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
                let selectedBook = SimpleBookManager.sharedInstance.books[indexPath.row]
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
                SimpleBookManager.sharedInstance.books[selectedIndexPath.row] = book
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }else {
                // Add a new book.
                let newIndexPath = NSIndexPath(forRow: SimpleBookManager.sharedInstance.books.count, inSection: 0)
                SimpleBookManager.sharedInstance.books.append(book)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            SimpleBookManager.sharedInstance.saveChanges()
            print(String( SimpleBookManager.sharedInstance.books.count))
            
        }
    }
    
}
