//
//  BookManagerProtocol.swift
//  Mobile Computing Lab
//
//  Created by Doni Ramadhan on 01/09/16.
//  Copyright © 2016 Ramacode. All rights reserved.
//

protocol BookManager {
    func count() -> Int
    
    func bookAtIndex(_:Int) -> Book
    
    func createBook() -> Book
    func allBooks() -> [Book]
    func removeBook(book:Book)
    
    func moveBookAtIndex(from:Int, toIndex to:Int)
    
    func minPrice() -> Int
    func maxPrice() -> Int
    func meanPrice() -> Float
    func totalCost() -> Int
    
    func saveChanges()
}