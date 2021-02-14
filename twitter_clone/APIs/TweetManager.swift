//
//  TweetManager.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 11/02/2021.
//

import Foundation
import FirebaseFirestoreSwift

class TweetManager {
    
    //MARK: -Properties
    static let shared = TweetManager()
    private let colName = "Tweets"
    
    enum TweetManagerError: Error {
        case FailedToCreate
    }
    
    //MARK: -Completion Handlers
    typealias createTweetCompletionHandler = (Result<Tweet , TweetManagerError>) ->Void
    typealias fetchTweetsCompletionHandler = (Result<[Tweet], TweetManagerError>) -> Void
    
    //MARK: -Functions
    func createTweet(_ tweet: Tweet, completion: @escaping createTweetCompletionHandler) -> Void {
        let docRef = db.collection(colName).document()
        tweet.setId(docRef.documentID)
        do {
            try docRef.setData(from: tweet)
            completion(.success(tweet))
        } catch _ {
            completion(.failure(.FailedToCreate))
        }
    }
    
    func fetchTweets(completion: @escaping fetchTweetsCompletionHandler) -> Void {
        db.collection(colName).getDocuments { (snapshot, error) in
            guard let docs = snapshot?.documents, error == nil else {
                completion(.failure(.FailedToCreate))
                return
            }
            
            var tweets = [Tweet]()
            docs.forEach { (doc) in
                
                tweets.append(Tweet(from: doc.data()))
            }
            
            completion(.success(tweets))
        }
    }
    
    func fetchTweets(for user: User, completion: @escaping fetchTweetsCompletionHandler) -> Void {
        db.collection(colName).whereField("userId", isEqualTo: user.userId).getDocuments { (snapshot, error) in
            guard let docs = snapshot?.documents, error == nil else {
                completion(.failure(.FailedToCreate))
                return
            }
            
            var tweets = [Tweet]()
            docs.forEach { (doc) in
                
                tweets.append(Tweet(from: doc.data()))
            }
            
            completion(.success(tweets))
        }
    }
}
