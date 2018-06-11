
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
    var listTimelineTableViewController: ListTimelineViewController! {
        didSet {
            listTimelineTableViewController.hideKeyboardDelegate = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json?q=nasa&result_type=popular"
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: nil, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("json: \(json)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
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
        searchText = recentSearches[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Searches"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
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
