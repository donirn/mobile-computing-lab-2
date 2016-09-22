//
//  BookViewController.swift
//  Lab2
//
//  Created by Hui Shen on 09/11/2016.
//  Copyright © 2016 Hui. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var searchWidthConstraint: NSLayoutConstraint!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        courseTextField.delegate = self
        isbnTextField.delegate = self
        priceTextField.delegate = self
        
        if let book = book {
            navigationItem.title = book.title
            titleLabel.text   = book.title
            authorLabel.text   = book.author
            courseTextField.text   = book.course
            isbnTextField.text   = book.isbn
            priceTextField.text   = String(book.price)
            publisherLabel.text = book.publisher
            
            isbnTextField.enabled = false
            searchWidthConstraint.constant = 0
        } else {
            saveButton.enabled = false
        }
    }
    
    @IBAction func retrieveBook(sender: AnyObject) {
        guard let isbn = isbnTextField.text else {return}
        BookService.shared.requestBook(isbn) { book in
            self.book = book
            dispatch_async(dispatch_get_main_queue(), {
                self.titleLabel.text = book?.title
                self.authorLabel.text = book?.author
                self.publisherLabel.text = book?.publisher
                self.saveButton.enabled = true
            })
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    // TODO: take a look if it is used
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        let isPresentingInAddBookMode = presentingViewController is UINavigationController
        if isPresentingInAddBookMode {
            dismissViewControllerAnimated(true, completion: nil)
        }else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            book?.course = courseTextField.text ?? ""
            book?.price = Int(priceTextField.text ?? "") ?? 0
        }
    }
    
    @IBAction func unwindToBookDetail(sender: UIStoryboardSegue) {
    }
    
    
    
}

