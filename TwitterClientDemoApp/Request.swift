//
//  Request.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import TwitterKit

class Request {
    
    let client = TWTRAPIClient()
    var clientError : NSError?
    
    func searchRequest(q: String) {
        let searchEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let paramsString = "?q=\(q)&result_type=popular&count=5"
        let request = client.urlRequest(withMethod: "GET", urlString: searchEndpoint+paramsString, parameters: nil, error: &clientError)
        
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
}
