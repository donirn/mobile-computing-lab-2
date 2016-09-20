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
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
            let title = titleLabel.text ?? ""
            let author = authorLabel.text ?? ""
            let course = courseTextField.text ?? ""
            let isbn = isbnTextField.text ?? ""
            let price = Int(priceTextField.text!) ?? 0
            book = Book(title: title, author: author, course: course,isbn: isbn, price: price)
        }
    }
    
    @IBAction func unwindToBookDetail(sender: UIStoryboardSegue) {
    }
    
    
    
}

