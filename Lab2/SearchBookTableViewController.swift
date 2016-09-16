//
//  SearchBookTableViewController.swift
//  Lab2
//
//  Created by Doni Ramadhan on 14/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class SearchBookTableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    let defaultSession = NSURLSession(configuration: .defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
    }
}

// MARK: - Table view data source
extension SearchBookTableViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension SearchBookTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
        guard let searchTerm = text.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet) else {return}
        guard let url = NSURL(string: "https://openlibrary.org/search.json?q=" + searchTerm) else {return}
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTaskWithURL(url){
            data, response, error in
            
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            guard error == nil else { print(error!.localizedDescription); return}
            guard (response as? NSHTTPURLResponse)?.statusCode == 200 else {return}
            
            if let data = data{
                self.updateSearchResults(data)
            }
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dataTask?.resume()
    }
    
    func updateSearchResults(data: NSData){
        do{
            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let docs = (dict as? NSDictionary)?["docs"] as? [NSDictionary]{
                var books = [Book]()
                for doc in docs{
                    if let title = doc["title"] as? String,
                        let isbn = (doc["isbn"] as? NSArray)?.firstObject as? String,
                        let author = (doc["author_name"] as? NSArray)?.firstObject as? String{
                        
                        if let book = Book(title: title, author: author, course: "", isbn: isbn, price: 0){
                            books.append(book)
                        }
                    }
                }
                for book in books{
                    print("\(book.isbn): \(book.title)")
                }
            }
        } catch let jsonError{
            print(jsonError)
        }
    }
}
