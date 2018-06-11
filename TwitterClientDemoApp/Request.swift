//
//  Request.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import TwitterKit

class Request {
    
    let searchEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
    
    let client = TWTRAPIClient()
    var clientError : NSError?
    
    func searchRequest(q: String, count: Int = 15, resultType: String = "popular", completion: ((_ result: AnyObject?) -> Void)?) {
        let paramsPath = "?q=\(q)&result_type=\(resultType)&count=\(count))"
        searchRequest(paramPath: paramsPath, completion: completion)
    }
    
    func searchRequest(paramPath: String, completion: ((_ result: AnyObject?) -> Void)?) {
        let request = client.urlRequest(withMethod: "GET", urlString: searchEndpoint+paramPath, parameters: nil, error: &clientError)
        
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
