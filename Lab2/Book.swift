//
//  Book.swift
//  Lab2
//
//  Created by Hui Shen on 09/11/2016.
//  Copyright © 2016 Hui. All rights reserved.

import UIKit

class Book : NSObject, NSCoding {
    // MARK: Properties
    
    var title: String
    var author: String
    var course: String
    var isbn: String
    var price: Int
    
    
    struct PropertyKey {
        static let titleKey = "title"
        static let authorKey = "author"
        static let courseKey = "course"
        static let isbnKey = "isbn"
        static let priceKey = "price"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("books")
    
    // MARK: Initialization
    
    init?(title: String, author: String, course: String,isbn: String, price: Int) {
        // Initialize stored properties.
        self.title = title
        self.author = author
        self.course = course
        self.isbn = isbn
        self.price  = price
        super.init()
        // Initialization should fail if there is no title.
        if title.isEmpty {
            return nil
        }
    }
    // MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(title, forKey: PropertyKey.titleKey)
        aCoder.encode(author, forKey: PropertyKey.authorKey)
        aCoder.encode(course, forKey: PropertyKey.courseKey)
        aCoder.encode(isbn, forKey: PropertyKey.isbnKey)
        aCoder.encode(price, forKey: PropertyKey.priceKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObject(forKey: PropertyKey.titleKey) as! String
        let author = aDecoder.decodeObject(forKey: PropertyKey.authorKey) as! String
        let course = aDecoder.decodeObject(forKey: PropertyKey.courseKey) as! String
        let isbn = aDecoder.decodeObject(forKey: PropertyKey.isbnKey) as! String
        let price = aDecoder.decodeObject(forKey: PropertyKey.priceKey) as! Int
        
        self.init(title: title, author: author, course: course,isbn: isbn, price: price)
        
    }
    
    
}
