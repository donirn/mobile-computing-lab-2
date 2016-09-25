//
//  BookService.swift
//  Lab2
//
//  Created by Doni Ramadhan on 22/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class BookService {
    static let shared = BookService()
    private init(){}
    
    private let session = NSURLSession(configuration:.defaultSessionConfiguration())
    private var dataTask: NSURLSessionDataTask?
    
    func requestBook(isbn: String, completion: (book: Book?) -> Void){
        guard let url = NSURL(string: "https://openlibrary.org/api/books?format=json&jscmd=data&bibkeys=ISBN:" + isbn) else {completion(book: nil); return}
        
        dataTask?.cancel()
        dataTask = session.dataTaskWithURL(url){
            data, response, error in
            
            guard error == nil else { completion(book: nil); return}
            let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            guard statusCode == 200 else { completion(book: nil);return}
            guard let data = data else {completion(book: nil) ;return}
            
            let book = self.getBook(data)
            book?.isbn = isbn
            completion(book: book)
            
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dataTask?.resume()
    }
    
    private func getBook(data: NSData) -> Book?{
        do{
            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            guard let bookDict = (dict as? [String: AnyObject])?.first?.1 as? NSDictionary else {return nil}
            let title = bookDict["title"] as? String ?? ""
            let author = ((bookDict["authors"] as? NSArray)?.firstObject as? NSDictionary)?["name"] as? String ?? ""
            let coverLink = (bookDict["cover"] as? NSDictionary)?["medium"] as? String ?? ""
            let publisher = ((bookDict["publishers"] as? NSArray)?.firstObject as? NSDictionary)?["name"] as? String ?? ""
            
            return Book(title: title, author: author, course: "", isbn: "", price: 0, publisher: publisher, coverLink: coverLink)
        } catch let jsonError{
            print(jsonError)
            return nil
        }
    }
}
