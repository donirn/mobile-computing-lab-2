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
    var publisher: String
    
    struct PropertyKey {
        static let titleKey = "title"
        static let authorKey = "author"
        static let courseKey = "course"
        static let isbnKey = "isbn"
        static let priceKey = "price"
        static let publisherKey = "publisher"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("books")
    
    // MARK: Initialization
    
    init?(title: String, author: String, course: String,isbn: String, price: Int, publisher: String) {
        // Initialize stored properties.
        self.title = title
        self.author = author
        self.course = course
        self.isbn = isbn
        self.price  = price
        self.publisher = publisher
        super.init()
        // Initialization should fail if there is no title.
        if title.isEmpty {
            return nil
        }
    }
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(author, forKey: PropertyKey.authorKey)
        aCoder.encodeObject(course, forKey: PropertyKey.courseKey)
        aCoder.encodeObject(isbn, forKey: PropertyKey.isbnKey)
        aCoder.encodeObject(price, forKey: PropertyKey.priceKey)
        aCoder.encodeObject(publisher, forKey: PropertyKey.publisherKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let author = aDecoder.decodeObjectForKey(PropertyKey.authorKey) as! String
        let course = aDecoder.decodeObjectForKey(PropertyKey.courseKey) as! String
        let isbn = aDecoder.decodeObjectForKey(PropertyKey.isbnKey) as! String
        let price = aDecoder.decodeObjectForKey(PropertyKey.priceKey) as! Int
        let publisher = aDecoder.decodeObjectForKey(PropertyKey.publisherKey) as? String ?? " "
        
        self.init(title: title, author: author, course: course,isbn: isbn, price: price, publisher: publisher)
        
    }
    
    
}
