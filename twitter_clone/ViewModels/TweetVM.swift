//
//  TweetVM.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 12/02/2021.
//

import UIKit

class TweetVM {
    
    //MARK: -Private Properties
    private var user: User? {
        didSet{
            guard let user = self.user else { return }
            self.userProfileImageUrl = user.getImageURL()
        }
    }
    private var tweet: Tweet? {
        didSet{
            self.fetchTweeterData()
        }
    }
    
    
    //MARK: -Public Properties
    var fullname: String {
        guard let user = self.user else { return "" }
        return user.fullname
    }
    
    var username: String {
        guard let user = self.user else { return "" }
        return user.username
    }
    
    var tweetTime: String {
        guard let tweet = self.tweet else { return "" }
        return self.getTweetTime(tweet.getTimeStamp())
    }
    
    var tweetText: String {
        guard let tweet = self.tweet else { return "" }
        return tweet.getText()
    }
    
    var userProfileImageUrl: URL!
    
    //MARK: -Inits
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    
    //MARK: -Functions
    private func fetchTweeterData() -> Void {
        guard let tweet = self.tweet else { return }
        UserManager.shared.getUser(with: tweet.getUserId()) { [weak self](getResult) in
            switch getResult {
            case.success(let tweetUser):
                self?.user = tweetUser
                break
            case.failure(_):
                return
            }
        }
    }
    
    private func getTweetTime(_ ts: Double) -> String {
        let formatter = DateComponentsFormatter()
        let now = Date()
        let originalTime = Date(timeIntervalSince1970: ts)
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: originalTime, to: now) ?? "1m"
    }
    
    func getTweetHeight(for width: CGFloat) -> CGFloat {
        let originHeight: CGFloat = 90
        let cellPaddings: CGFloat = 40
        let measurer = UILabel()
        measurer.text = self.tweetText
        measurer.numberOfLines = 0
        measurer.lineBreakMode = .byWordWrapping
        measurer.setWdith(width - cellPaddings)
        return measurer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + originHeight
    }
}
