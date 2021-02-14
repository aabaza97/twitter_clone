//
//  FollowManager.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 14/02/2021.
//

import FirebaseFirestoreSwift

enum FollowErrors: Error {
    case FailedToFollow
    case FailedToUnFollow
    case FailedToFind
    
    var description: String {
        switch self {
        case .FailedToFind: return ""
            
        case .FailedToFollow: return ""
            
        case .FailedToUnFollow: return ""
        }
    }
    
}

class FollowManager {
    //MARK: -Properties
    public static let shared = FollowManager()
    
    private let colName: String = "Follows"
    
    
    
    //MARK: -Typenames
    typealias followCompletionHandler = (FollowErrors?) -> Void
    typealias followCountCompletionHanlder = (Int) -> Void
    
    //MARK: -Functions
    public func follow(_ follow: Follow, completion: @escaping followCompletionHandler) -> Void {
        let docRef = db.collection(colName).document(follow.id)
        do {
            try docRef.setData(from: follow)
            completion(nil)
        } catch _ {
            completion(.FailedToFollow)
        }
    }
    
    public func unFollow(_ follow: Follow, completion: @escaping followCompletionHandler) -> Void {
        let docRef = db.collection(colName).document(follow.id)
        docRef.delete { (error) in
            guard error == nil else { completion(.FailedToUnFollow); return }
            completion(nil)
        }
    }
    
    public func checkFollowStatus(for user: User, completion: @escaping followCompletionHandler) -> Void {
        let appUserId: String = GlobalUser.shared.getId()
        let followID: String = appUserId + "_" + user.userId
        
        db.collection(colName).document(followID).getDocument { (_, error) in
            guard error == nil else { completion(.FailedToFind); return}
            completion(nil)
        }
    }
    
    public func getFollowersCount(completion: @escaping followCountCompletionHanlder) -> Void {
        db.collection(colName).whereField("followeeId", isEqualTo: GlobalUser.shared.getId()).getDocuments { (snapshot, error) in
            guard let count = snapshot?.count, error == nil else { completion(0); return}
            completion(count)
        }
    }

    public func getFollowingCount(completion: @escaping followCountCompletionHanlder) -> Void {
        db.collection(colName).whereField("follwerId", isEqualTo: GlobalUser.shared.getId()).getDocuments { (snapshot, error) in
            guard let count = snapshot?.count, error == nil else { completion(0); return}
            completion(count)
        }
    }
}
