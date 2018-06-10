
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
    var searchController: UISearchController! {
        didSet {
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
        }
    }
    var listTimelineTableViewController: ListTimelineViewController! {
        didSet {
            listTimelineTableViewController.hideKeyboardDelegate = self
        }
    }
    
    var searchText: String {
        return searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = false
        
        configureSearchController()
    }
    
    private func configureSearchController() {
        listTimelineTableViewController = ListTimelineViewController()
        
        searchController = UISearchController(searchResultsController: listTimelineTableViewController)
        searchController.searchBar.placeholder = "Search Twitter"
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source and delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }

    let cellIdentifier = "rightDetailCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = recentSearches[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

// Delegate function for pressing search button

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchText.isEmpty {
            recentSearches.append(searchText)
            tableView.reloadData()
        }
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        listTimelineTableViewController.updateSearch(q: searchText)
    }
}

extension SearchTableViewController: HideKeyboardDelegate {
    func hideKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}
