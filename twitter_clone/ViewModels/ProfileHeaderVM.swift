//
//  ProfileHeaderVM.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 13/02/2021.
//

import UIKit

enum FilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets:
            return "Tweets"
        case.replies:
            return "Tweets & replies"
        case.likes:
            return "Likes"
        }
    }
}


class ProfileHeaderVM {
    //MARK: -Data members
    private var user: User! {
        didSet {
            self.getFollowersCount()
            self.getFollowingCount()
        }
    }
    
    private var _followersCount: Int = 3
    
    private var _followingsCount: Int  = 2
    
    private var _isFollowing: Bool = false
    
    
    //MARK: -Properties
    public var profileUserId: String!
    
    public var isMe: Bool {
        return GlobalUser.shared.getId() == self.user.userId
    }
    
    public var isFollowing: Bool{
        return _isFollowing
    }
    
    public var followingsCount: Int {
        return _followingsCount
    }
    
    public var followersCount: Int {
        return _followersCount
    }
    
    public var fullname: String {
        return self.user.fullname
    }
    
    public var username: String {
        return "@" + self.user.username.lowercased()
    }
    
    public var bioInfo: String {
        return "An Engineer who likes to read, write, watch, observe and mutate."
    }
    
    public var followersInfo: NSAttributedString {
        return getFollowingInfoAttributedText(with: _followersCount, andDescription: "Followers")
    }
    
    public var followingInfo: NSAttributedString {
        return getFollowingInfoAttributedText(with: _followingsCount, andDescription: "Following")
    }
    
    public var mainButtonTitle: String {
        if self.user.userId == GlobalUser.shared.getId() {
            return "Edit Profile"
        } else {
            return self._isFollowing ? "Unfollow" : "Follow"
        }
    }
    
    public var mainButtonTitleColor: UIColor {
        if self.user.userId == GlobalUser.shared.getId(){
            return .twitterBlue
        } else {
            return self._isFollowing ? .white : .twitterBlue
        }
    }
    
    public var mainButtonBackgrounColor: UIColor {
        if self.user.userId == GlobalUser.shared.getId(){
            return .clear
        } else {
            return self._isFollowing ? .systemRed : .clear
        }
    }
    
    public var mainButtonBorderColor: UIColor {
        if self.user.userId == GlobalUser.shared.getId(){
            return .twitterBlue
        } else {
            return self._isFollowing ? .red : .twitterBlue
        }
    }
    
    public var profileImageURL: URL {
        return self.user.getImageURL()
    }
    
    //MARK: -Inits
    init(user: User) {
        self.user = user
        self.profileUserId = user.userId
    }
    
    //MARK: -Functions
    
    
    private func getFollowingInfoAttributedText(with value: Int, andDescription text: String) -> NSAttributedString{
        let countAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.black.cgColor,
                                                               NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]
        let descriptionAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor,
                                                                     NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]
       
        let infoText = NSMutableAttributedString(string: String(value), attributes: countAttributes)
        infoText.append(NSAttributedString(string: " \(text)", attributes: descriptionAttributes))
        
        return infoText
    }
    
    private func getFollowersCount () -> Void {
        FollowManager.shared.getFollowersCount { (count) in
            self._followersCount = count
        }
        
    }

    private func getFollowingCount () -> Void {
        FollowManager.shared.getFollowingCount { (count) in
            self._followersCount = count
        }
    }

    private func getFollowingStatus() -> Void {
        FollowManager.shared.checkFollowStatus(for: self.user) { (error) in
            guard error == nil else { return }
            self._isFollowing = true
        }
    }
    
    public func toggleFollowingStatus() -> Void {
        self._isFollowing = !self._isFollowing
    }
}
