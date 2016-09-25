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
        
        let book1 = Book(title: "1000 Nights", author: "Alibaba",course: "Math",  isbn: "1234",  price: 30, publisher: "New York Times", coverLink: "")
        let book2 = Book(title: "Cinderella",author: "Bawaw", course: "History", isbn: "321",  price: 12, publisher: "New York Times", coverLink: "")
        let book3 = Book(title: "Three Musketeers", author: "Musketeer", course: "History", isbn: "2152",  price: 52, publisher: "New York Times", coverLink: "")
        let book4 = Book(title: "Snow White", author: "Greela", course: "Math", isbn: "6634",  price: 32, publisher: "New York Times", coverLink: "")
        let book5 = Book(title: "Shopping Mall", author: "Tyison", course: "Architecture",isbn: "21312",  price: 100, publisher: "New York Times", coverLink: "")
        books = [book1!, book2!, book3!, book4!, book5!]
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
