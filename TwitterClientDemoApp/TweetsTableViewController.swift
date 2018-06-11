//
//  TweetsTableViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit
import TwitterKit

class TweetsTableViewController: UITableViewController {

    var tweets = [TWTRTweet]()
    var nextResultSubpath: String?
    
    var hideKeyboardDelegate: HideKeyboardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: String(describing: TWTRTweetTableViewCell.self))
    }

    func updateSearch(q: String) {
        Request().searchRequest(q: q) { (data) in
            guard let object = data else {
                self.log("No data got back")
                return
            }
            
            if let metadata = object["search_metadata"] as? [String: AnyObject], let nextResult = metadata["next_results"] as? String {
                self.nextResultSubpath = nextResult
            }
            if let statuses = object["statuses"] as? [[String: AnyObject]] {
                for object in statuses {
                    if let tweet = TWTRTweet(jsonDictionary: object) {
                        self.tweets.append(tweet)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TWTRTweetTableViewCell.self), for: indexPath) as? TWTRTweetTableViewCell {
            cell.configure(with: tweets[indexPath.row])
            return cell
        } else {
            fatalError("TableCell type doesn't match")
        }
    }
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remember to move tweet at index path before deleting
            tweets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboardDelegate?.hideKeyboard()
    }

    private func log(_ whatToLog: Any) {
        debugPrint("\(TweetsTableViewController.self): \(whatToLog)")
    }
}
