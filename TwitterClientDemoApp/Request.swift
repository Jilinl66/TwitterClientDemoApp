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
    func searchRequest(q: String, count: Int = 15, resultType: String = "popular", completion: ((_ result: AnyObject?) -> Void)?) {
        let paramsPath = "?q=\(q)&result_type=\(resultType)&count=\(count))"
        searchRequest(withParamPath: paramsPath, completion: completion)
    }
    
    // Search request with subpath
    func searchRequest(withParamPath subPath : String, completion: ((_ result: AnyObject?) -> Void)?) {
        let searchEndpoint = "\(twitterServer)/search/tweets.json"
        let path = searchEndpoint + subPath
        
        request(path: path, completion: completion)
    }
    
    // Make api request
    private func request(path: String, completion: ((_ result: AnyObject?) -> Void)?) {
        let request = client.urlRequest(withMethod: "GET", urlString: path, parameters: nil, error: &clientError)
        
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
