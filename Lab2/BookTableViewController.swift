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
               navigationItem.leftBarButtonItem = editButtonItem
        let bgImage = UIImage(named: "subtle_white_feathers")
        navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SimpleBookManager.sharedInstance.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BookTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookTableViewCell
        
        // Fetches the appropriate book for the data source layout.
        let book = SimpleBookManager.sharedInstance.books[indexPath.row]
        
        cell.titleLabel.text = book.title
        cell.authorLabel.text = "by \(book.author)"
        cell.priceLabel.text = "\(book.price) SEK"
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        
        SimpleBookManager.sharedInstance.moveBookAtIndex(fromIndexPath.row, toIndex: toIndexPath.row)
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            SimpleBookManager.sharedInstance.books.remove(at: indexPath.row)
            SimpleBookManager.sharedInstance.saveChanges()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let bookDetailViewController = segue.destination as! BookDetailViewController
            
            // Get the cell that generated this segue.
            if let selectedBookCell = sender as? BookTableViewCell {
                let indexPath = tableView.indexPath(for: selectedBookCell)!
                let selectedBook = SimpleBookManager.sharedInstance.books[(indexPath as NSIndexPath).row]
                bookDetailViewController.book = selectedBook
            }
        }
        else if segue.identifier == "AddBook" {
            print("Adding new book.")
        }
    }
    
    
    @IBAction func unwindToBookList(_ sender: UIStoryboardSegue) {
        
        
        if let sourceViewController = sender.source as? BookViewController, let book = sourceViewController.book {
            // Add a new book item.
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                SimpleBookManager.sharedInstance.books[selectedIndexPath.row] = book
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // Add a new book.
                let newIndexPath = IndexPath(row: SimpleBookManager.sharedInstance.books.count, section: 0)
                SimpleBookManager.sharedInstance.books.append(book)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            SimpleBookManager.sharedInstance.saveChanges()
            print(String( SimpleBookManager.sharedInstance.books.count))
            
        }
    }
    
}
