//z `//  ListTimelineViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit
import TwitterKit

protocol HideKeyboardDelegate {
    func hideKeyboard()
}

class ListTimelineViewController: TWTRTimelineViewController {
    
    var hideKeyboardDelegate: HideKeyboardDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        showTweetActions = true
    }

    private func configureDataSource(q: String) -> TWTRTimelineDataSource {
        let searchQuery = q
        let client = TWTRAPIClient()
        let dataSource = TWTRSearchTimelineDataSource(searchQuery: searchQuery, apiClient: client)
        dataSource.resultType = "popular"
        return dataSource
    }
    
    func updateSearch(q: String) {
        DispatchQueue.main.async {
            self.dataSource = self.configureDataSource(q: q)
        }
    }
    
    // MARK: - Table view data source
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboardDelegate?.hideKeyboard()
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.beginUpdates()
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
        }
    }
}
