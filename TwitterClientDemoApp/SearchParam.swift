//
//  SearchParam.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/10/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

struct SearchParam {
    
    struct Keys {
        static let query = "q"
        static let count = "count"
        static let resultType = "result_type"
        static let maxId = "max_id"
    }
    
    var query: String
    var count: Int?
    var resultType: String?
    var maxId: String?
    
    init(query: String, count: Int? = nil, resultType: String? = nil, maxId: String? = nil) {
        self.query = query
        self.count = count
        self.resultType = resultType
        self.maxId = maxId
    }
    
    func generateParams() -> [String: Any] {
        var params: [String: Any] = [Keys.query: preprocessQuery(query)]
        if count != nil {
            params[Keys.count] = "\(count!)"
        }
        if resultType != nil {
            params[Keys.resultType] = resultType!
        }
        if maxId != nil {
            params[Keys.maxId] = maxId!
        }
        return params
    }
    
    // Remove invalide character: back slash
    private func preprocessQuery(_ query: String) -> String {
        let specialCharacter = ["\\", ",", ".", "@", "*", "^", "$", "#"]
        var newQuery = ""
        var hasHashTag = false
        for char in query {
            let specialString = String(char)
            if !specialCharacter.contains(specialString) {
                newQuery += specialString
            }
            if specialString == "#" {
                hasHashTag = true
            }
        }
        if hasHashTag {
            newQuery = "#\(newQuery)"
        }
        return newQuery
    }
    
    func isValidQuery() -> Bool {
        let newQuery =  preprocessQuery(query)
        return !newQuery.isEmpty && newQuery != "#"
    }
}
