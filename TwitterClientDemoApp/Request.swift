//
//  Request.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import TwitterKit

class Request {
    
    let twitterServer = "https://api.twitter.com/1.1"
    
    let client = TWTRAPIClient()
    var clientError : NSError?
    
    // Search request with params
    func searchRequest(searchParam: SearchParam, completion: ((_ result: AnyObject?) -> Void)?) {
        let searchEndpoint = "\(twitterServer)/search/tweets.json"
        if searchParam.isValidQuery() {
            request(path: searchEndpoint, params: searchParam.generateParams(), completion: completion)
        }
    }
    
    // Make api request
    private func request(path: String, params: [String: Any]?, completion: ((_ result: AnyObject?) ->  Void)?) {
        let request = client.urlRequest(withMethod: "GET", urlString: path, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                self.log("Error: \(String(describing: connectionError))")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                completion?(json as AnyObject)
            } catch let jsonError as NSError {
                self.log("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    private func log(_ whatToLog: Any) {
        print("\(Request.self): \(whatToLog)")
    }
}
