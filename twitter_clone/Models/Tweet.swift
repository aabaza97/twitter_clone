//
//  Tweet.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 11/02/2021.
//

import Foundation

class Tweet: Codable {
    
    //MARK: -Properties
    private var tweetId: String
    private let text: String
    private let userId: String
    private let timeStamp: Double
    private var likes: Int
    private var retweets: Int
    
    
    //MARK: -Inits
    init(from data: [String: Any]) {
        self.tweetId = data["tweetId"] as! String
        self.text = data["text"] as! String
        self.userId = data["userId"] as! String
        self.timeStamp = data["timeStamp"] as! Double
        self.likes = data["likes"] as! Int
        self.retweets = data["retweets"] as! Int
    }
    
    
    init(id: String = "", text: String, userId: String, timeStamp: Double, likes: Int = 0, retweets: Int = 0) {
        self.tweetId = id
        self.text = text
        self.likes = likes
        self.retweets = retweets
        self.timeStamp = timeStamp
        self.userId = userId
    }
    
    //MARK: -Getters
    func getId() -> String {
        return self.tweetId
    }
    func getUserId() -> String {
        return self.userId
    }
    func getText() -> String {
        return self.text
    }
    func getLikes() -> Int {
        return self.likes
    }
    func getRetweets() -> Int {
        return self.retweets
    }
    func getTimeStamp() -> Double {
        return self.timeStamp
    }
    
    //MARK: -Setters
    func setId(_ id: String) -> Void {
        self.tweetId = id
    }
    func setLikes(_ likes: Int) -> Void {
        self.likes = likes
    }
    func setRetweets(_ retweets: Int) -> Void {
        self.retweets = retweets
    }
    

}
