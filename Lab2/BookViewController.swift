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
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var courseTextField: UITextField!
    
    @IBOutlet weak var isbnTextField: UITextField!
    
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self
        authorTextField.delegate = self
        courseTextField.delegate = self
        isbnTextField.delegate = self
        priceTextField.delegate = self
        
        
        if let book = book {
            navigationItem.title = book.title
            titleTextField.text   = book.title
            authorTextField.text   = book.author
            courseTextField.text   = book.course
            isbnTextField.text   = book.isbn
            priceTextField.text   = String(book.price)
            
        }
        
        checkValidBookTitle()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidBookTitle()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        //  saveButton.enabled = false
    }
    
    func checkValidBookTitle() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        let isPresentingInAddBookMode = presentingViewController is UINavigationController
        if isPresentingInAddBookMode {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let senderButton = sender as? UIBarButtonItem, saveButton === senderButton {
            let title = titleTextField.text ?? ""
            let author = authorTextField.text ?? ""
            let course = courseTextField.text ?? ""
            let isbn = isbnTextField.text ?? ""
            let price = Int(priceTextField.text!) ?? 0
            book = Book(title: title, author: author, course: course,isbn: isbn, price: price)
        }
    }
    
    @IBAction func unwindToBookDetail(_ sender: UIStoryboardSegue) {
    }
    
    
    
}

