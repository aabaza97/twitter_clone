//
//  Follow.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 14/02/2021.
//

import Foundation

struct Follow: Codable {
    let id: String
    let followerId: String
    let followeeId: String
    
    init(followerId: String, followeeId: String) {
        self.id = followerId + "_" + followeeId
        self.followerId = followerId
        self.followeeId = followeeId
    }
    
    init(from data: [String : Any]) {
        self.id = data["followId"] as! String
        self.followerId = data["followerId"] as! String
        self.followeeId = data["followeeId"] as! String
    }
}
