
//
//  SearchTableViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit
import TwitterKit

class SearchTableViewController: UITableViewController {

    var recentSearches = [String]()
    var searchController: UISearchController! {
        didSet {
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
        }
    }
    var tweetsTableViewController: TweetsTableViewController! {
        didSet {
            tweetsTableViewController.hideKeyboardDelegate = self
        }
    }
    
    var searchText: String {
        get {
            return searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
        }
        set {
            DispatchQueue.main.async {
                self.searchController.searchBar.text = newValue
                self.searchController.isActive = true
            }
        }
    }
    var lastSearchText: String?
    
    var timer: Timer?
    var searchTimeInterval: TimeInterval = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func configureSearchController() {
        tweetsTableViewController = TweetsTableViewController()
        
        searchController = UISearchController(searchResultsController: tweetsTableViewController)
        
        searchController.searchBar.placeholder = "Search Twitter"
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    // MARK: Table view data source and delegate

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
        searchText = recentSearches[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if recentSearches.count == 0 {
            return "Searching for people, topics, or keywords"
        } else {
            return "Recent Searches"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight = CGFloat(44)
        return headerHeight
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

// MARK: Delegate function for pressing search button

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
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: searchTimeInterval, repeats: true) { _ in
                self.checkAndUpdateSearch()
            }
        }
    }
    
    private func checkAndUpdateSearch() {
        if !searchText.isEmpty && (lastSearchText == nil || searchText != lastSearchText!) {
            tweetsTableViewController.updateSearch(q: searchText)
            lastSearchText = searchText
        }
    }
}

// MARK: Table view delegate function for hiding keyboard

extension SearchTableViewController: HideKeyboardDelegate {
    func hideKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}
