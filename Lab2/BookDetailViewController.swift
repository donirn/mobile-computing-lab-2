//
//  BookDetailViewController.swift
//  Lab2
//
//  Created by Hui on 10/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var priceTextField: UILabel!
    @IBOutlet weak var isbnTextField: UILabel!
    @IBOutlet weak var authorTextField: UILabel!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var courseTextField: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var book:Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book{
            priceTextField.text = String(book.price)
            isbnTextField.text  = book.isbn
            authorTextField.text  = book.author
            titleTextField.text = book.title
            courseTextField.text  = book.course
            publisherLabel.text = book.publisher
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if editButton === sender {
            
            let bookDetailViewController = segue.destinationViewController as! BookViewController
            
            bookDetailViewController.book = book
            
        }
    }
    
    
    
}
