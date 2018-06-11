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

    struct TweetKeys {
        static let searchMetadata = "search_metadata"
        static let nextResults = "next_results"
    }
    
    var tweets = [TWTRTweet]()
    var nextResultSubpath: String?
    
    var hideKeyboardDelegate: HideKeyboardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register TWTRTweetTableViewCell from Twitter Kit
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: String(describing: TWTRTweetTableViewCell.self))
    }

    func updateSearch(q: String) {
        tweets = []
        Request().searchRequest(q: q, completion: fetchedTweetsCallback)
    }
    
    func fetchedTweetsCallback(data: AnyObject?) -> Void {
        guard let object = data else {
            self.log("No data returned")
            return
        }
//        print(object["search_metadata"] )
        if let metadata = object[TweetKeys.searchMetadata] as? [String: AnyObject], let nextResult = metadata[TweetKeys.nextResults] as? String {
            self.nextResultSubpath = nextResult
        } else {
            self.nextResultSubpath = nil
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
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TWTRTweetTableViewCell.self), for: indexPath) as? TWTRTweetTableViewCell {
            cell.configure(with: tweets[indexPath.row])
            return cell
        } else {
            fatalError("TableCell type doesn't match type \(String(describing: TWTRTweetTableViewCell.self))")
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
            if nextResultSubpath != nil {
                let numOfMoreTweet = 5
                let paramPath = "\(nextResultSubpath!)&count=\(numOfMoreTweet)"
                Request().searchRequest(withParamPath: paramPath, completion: fetchedTweetsCallback)
            }
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboardDelegate?.hideKeyboard()
    }

    private func log(_ whatToLog: Any) {
        debugPrint("\(TweetsTableViewController.self): \(whatToLog)")
    }
}
