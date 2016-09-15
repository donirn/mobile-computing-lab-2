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
        print("search pressed: \(searchBar.text)")
    }
}
