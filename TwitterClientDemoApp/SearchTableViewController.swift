
//
//  SearchTableViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var recentSearches = [String]()
    var searchController: UISearchController!
    var listTimelineTableViewController = ListTimelineViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recentSearches = ["Music", "Cooking"]

         clearsSelectionOnViewWillAppear = false
        
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: listTimelineTableViewController)
        searchController.searchBar.placeholder = "Search Twitter"
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }

    let cellIdentifier = "rightDetailCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = recentSearches[indexPath.row]
        return cell
    }

}
