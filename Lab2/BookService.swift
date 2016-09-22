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
    typealias BookCompletionHandler = (inner: () throws -> NSData) -> Void
    
    enum Error: ErrorType {
        case UrlString, StatusCode(code: Int?), NullData
    }
    
    func requestBook(isbn: String, completion: BookCompletionHandler){
        guard let url = NSURL(string: "https://openlibrary.org/api/books?format=json&jscmd=data&bibkeys=ISBN:" + isbn) else {completion(inner: {throw Error.UrlString}); return}
        
        dataTask?.cancel()
        dataTask = session.dataTaskWithURL(url){
            data, response, error in
            
            guard error == nil else { completion(inner: {throw error!}); return}
            let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            guard statusCode == 200 else { completion(inner: {throw Error.StatusCode(code: statusCode)});return}
            guard let data = data else {completion(inner: {throw Error.NullData}) ;return}
            completion(inner: {return data})
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dataTask?.resume()
    }
}
