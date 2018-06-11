//z `//  ListTimelineViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit
import TwitterKit

/*
    This class is not actually used, this is only for purpose of demo TWTRTimelineViewController
 */

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
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboardDelegate?.hideKeyboard()
    }
}
