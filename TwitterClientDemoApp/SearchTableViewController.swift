
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recentSearches = ["Music", "Cooking"]

         clearsSelectionOnViewWillAppear = false
         navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recentSearches.count
    }

    let cellIdentifier = "rightDetailCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = recentSearches[indexPath.row]
        return cell
    }

}
