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
    
    let session = NSURLSession(configuration:.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    typealias BookCompletionHandler = (book: Book?) -> Void
    
    enum Error: ErrorType {
        case UrlString, StatusCode(code: Int?), NullData
    }
    
    func requestBook(isbn: String, completion: BookCompletionHandler){
        guard let url = NSURL(string: "https://openlibrary.org/api/books?format=json&jscmd=data&bibkeys=ISBN:" + isbn) else {completion(book: nil); return}
        
        dataTask?.cancel()
        dataTask = session.dataTaskWithURL(url){
            data, response, error in
            
            guard error == nil else { completion(book: nil); return}
            let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            guard statusCode == 200 else { completion(book: nil);return}
            guard let data = data else {completion(book: nil) ;return}
            completion(book: self.getBook(data))
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dataTask?.resume()
    }
    
    func getBook(data: NSData) -> Book?{
        return nil
    }
}
