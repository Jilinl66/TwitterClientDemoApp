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
    var currSearchParam: SearchParam!
    var nextMaxId: String?
    
    var hideKeyboardDelegate: HideKeyboardDelegate?
    
    var noResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register TWTRTweetTableViewCell from Twitter Kit
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: String(describing: TWTRTweetTableViewCell.self))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let labelWidth = CGFloat(100)
        let labelHeight = CGFloat(40)
        noResultLabel = UILabel(frame: CGRect(x: tableView.bounds.midX - labelWidth/2, y: tableView.bounds.midY - labelHeight/2, width: labelWidth, height: labelHeight))
        noResultLabel.text = "No Tweets"
        noResultLabel.sizeToFit()
        tableView.addSubview(noResultLabel)
        
        noResultLabel.isHidden = true
    }
    
    func updateSearch(q: String) {
        tweets = []
        nextMaxId = nil
        currSearchParam = SearchParam(query: q, resultType: "popular")
        Request().searchRequest(searchParam: currSearchParam, completion: fetchedTweetsCallback)
    }
    
    func fetchedTweetsCallback(data: AnyObject?) -> Void {
        guard let object = data else {
            self.log("No data returned")
            return
        }
        if let metadata = object[TweetKeys.searchMetadata] as? [String: AnyObject], let nextResult = metadata[TweetKeys.nextResults] as? String {
            if let maxId = parseMaxId(nextResult: nextResult) {
                self.nextMaxId = maxId
            } else {
                self.nextMaxId = nil
            }
        } else {
            self.nextMaxId = nil
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
    
    private func parseMaxId(nextResult: String) -> String? {
        let components = nextResult.components(separatedBy: ["=", "&"])
        if components.count >= 2 {
            return components[1]
        } else {
            return nil
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noResultLabel != nil {
            noResultLabel.isHidden = tweets.count != 0
        }
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
            if nextMaxId != nil {
                let numOfMoreTweet = 5
                currSearchParam.count = numOfMoreTweet
                currSearchParam.maxId = nextMaxId
                Request().searchRequest(searchParam: currSearchParam, completion: fetchedTweetsCallback)
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
