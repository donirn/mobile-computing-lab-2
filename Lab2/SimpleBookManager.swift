//
//  SimpleBookManager.swift
//  Mobile Computing Lab
//
//  Created by Doni Ramadhan on 01/09/16.
//  Copyright © 2016 Ramacode. All rights reserved.
//

import Foundation


class SimpleBookManager: BookManager {
    var books = [Book]()
    static let sharedInstance  = SimpleBookManager()
    private init(){
        
        if let savedBooks = loadBooks() {
            books = savedBooks
            print("load exsisting books")
        }else {
            // Load the sample data.
            loadSampleBooks()
            print("load sample books")
        }
    }
    
    
    func loadSampleBooks() {
        guard let book1 = Book(title: "Zen speaks", author: "Zhizhong Cai", course: "Literature", isbn: "0385472579", price: 100, publisher: "Anchor Books", coverLink: "https://covers.openlibrary.org/b/id/240726-M.jpg") else {return}
        
        guard let book2 = Book(title: "The adventures of Tom Sawyer", author: "Mark Twain", course: "Fiction", isbn: "0451526538", price: 50, publisher: "Signet Classic", coverLink: "https://covers.openlibrary.org/b/id/295577-M.jpg") else {return}
        
        books = [book1, book2]
    }
    
    func loadBooks() -> [Book]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Book.ArchiveURL!.path!) as? [Book]
    }
    
    func count() -> Int {
        return books.count
    }
    
    func bookAtIndex(index: Int) -> Book {
        return books[index]
    }
    
    func createBook() -> Book {
        let book = Book(title: "", author: "",course: "",  isbn: "",  price: 0, publisher: "", coverLink: "")
        books.append(book!)
        return book!
    }
    
    func allBooks() -> [Book] {
        return books
    }
    
    func removeBook(book: Book) {
        if let index = books.indexOf(book){
            books.removeAtIndex(index)
        }
        saveChanges()
    }
    
    func moveBookAtIndex(from: Int, toIndex to: Int) {
        let element = books.removeAtIndex(from)
        books.insert(element, atIndex: to)
        saveChanges()
    }
    
    func minPrice() -> Int {
        let book = books.minElement { (book1, book2) -> Bool in
            return book1.price < book2.price
        }
        
        return book?.price ?? 0
    }
    
    func maxPrice() -> Int {
        let book = books.maxElement { (book1, book2) -> Bool in
            return book1.price < book2.price
        }
        
        return book?.price ?? 0
    }
    
    func meanPrice() -> Float {
        if count() > 0{
            return Float(totalCost())/Float(count())
        }else{
            return 0
        }
        
    }
    
    func totalCost() -> Int {
        return books.reduce(0) { (price, book) -> Int in
            return price + book.price
        }
    }
    
    func saveChanges() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(books, toFile: Book.ArchiveURL!.path!)
        if !isSuccessfulSave {
            print("Failed to save books...")
        }else{
            print("Save successfull")
        }
    }
}
