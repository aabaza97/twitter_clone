//
//  TweetCell.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 11/02/2021.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    //MARK: -Logic Properties
    private var user: User? {
        didSet{
            guard let user = self.user else { return }
            guard let imgURL = URL(string: user.image) else {return}
            self.userProfileImage.sd_setImage(with: imgURL , completed: nil)
            self.fullNameLabel.text = user.fullname
            self.usernameLabel.text = "@\(user.username.lowercased())"
        }
    }
    var tweet: Tweet? {
        didSet{
            guard let tweet = self.tweet else { return }
            self.fetchUserData(tweet.getUserId())
            self.tweetTextLabel.text = tweet.getText()
            self.timeLabel.text = " ・ \(self.getTweetTimeStamp(tweet.getTimeStamp()))"
        }
    }
    
    
    //MARK: -UI Properties
    private lazy var userProfileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.setDimensions(width: 50, height: 50)
        imgView.layer.cornerRadius = 25
        imgView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTweeterProfile))
        imgView.addGestureRecognizer(tapGesture)
        return imgView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTweeterProfile))
        lbl.addGestureRecognizer(tapGesture)
        return lbl
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTweeterProfile))
        lbl.addGestureRecognizer(tapGesture)
        return lbl
    }()
    
    private let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .gray
        return lbl
    }()
    
    private let tweetTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(scale: .medium)
        btn.setImage(UIImage(systemName: "ellipsis", withConfiguration: imgConfig), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(replyButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var replyButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(scale: .medium)
        btn.setImage(UIImage(systemName: "message", withConfiguration: imgConfig), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(replyButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var retweetButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(scale: .medium)
        btn.setImage(UIImage(systemName: "arrow.2.squarepath", withConfiguration: imgConfig), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(retweetButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(scale: .medium)
        btn.setImage(UIImage(systemName: "suit.heart", withConfiguration: imgConfig), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(scale: .medium)
        btn.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: imgConfig), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [replyButton, retweetButton, likeButton, shareButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    //MARK: -Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Selectors
    @objc
    private func replyButtonPressed() -> Void {
        print("replying..")
    }
    
    @objc
    private func retweetButtonPressed() -> Void {
        print("retweeting..")
    }
    
    @objc
    private func likeButtonPressed() -> Void {
        print("liking..")
    }
    
    @objc
    private func shareButtonPressed() -> Void {
        print("sharing..")
    }
    
    @objc
    private func showTweeterProfile() -> Void {
        guard let user = self.user else { return }
        print("Showing user(\(user.fullname))'s Profile")
    }
    
    //MARK: -Functions
    private func fetchUserData(_ id: String) -> Void {
        UserManager.shared.getUser(with: id) { [weak self](getResult) in
            switch getResult {
            case.success(let tweetUser):
                self?.user = tweetUser
                break
            case.failure(_):
                return
            }
        }
    }
    
    private func configureView() -> Void {
        let spaceBetweenImageAndLabels: CGFloat = 12
        let cellMargin: CGFloat = 16
        
        self.backgroundColor = .white
        
        self.addSubview(userProfileImage)
        self.addSubview(fullNameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(timeLabel)
        self.addSubview(actionButton)
        self.addSubview(tweetTextLabel)
        self.addSubview(hStack)
        self.addSubview(separatorView)
        
        
        self.userProfileImage.anchor(top: self.topAnchor,
                                     left: self.leftAnchor,
                                     marginTop: cellMargin,
                                     marginLeft: cellMargin)
        self.fullNameLabel.anchor(top: self.topAnchor,
                                  left: self.userProfileImage.rightAnchor,
                                  marginTop: cellMargin,
                                  marginLeft: spaceBetweenImageAndLabels)
        self.usernameLabel.anchor(top: self.topAnchor,
                                  left: self.fullNameLabel.rightAnchor,
                                  marginTop: cellMargin,
                                  marginLeft: 8)
        self.timeLabel.anchor(top: self.topAnchor,
                                  left: self.usernameLabel.rightAnchor,
                                  marginTop: cellMargin)
        self.actionButton.anchor(top: self.topAnchor,
                                 right: self.rightAnchor,
                                 marginTop: cellMargin,
                                 marginRight: cellMargin + 4)
        self.tweetTextLabel.anchor(top: self.fullNameLabel.bottomAnchor,
                                   left: self.userProfileImage.rightAnchor,
                                   marginTop: 8,
                                   marginLeft: spaceBetweenImageAndLabels,
                                   marginRight: cellMargin)
        self.hStack.anchor(left: self.userProfileImage.rightAnchor,
                           bottom: self.separatorView.topAnchor,
                           right: self.rightAnchor,
                           marginLeft: spaceBetweenImageAndLabels,
                           marginBottom: cellMargin,
                           marginRight: cellMargin + 4)
        self.separatorView.anchor(left: self.leftAnchor,
                                  bottom: self.bottomAnchor,
                                  right: self.rightAnchor,
                                  marginTop: 5)
    }
    
    private func getTweetTimeStamp(_ ts: Double) -> String {
        let formatter = DateComponentsFormatter()
        let now = Date()
        let originalTime = Date(timeIntervalSince1970: ts)
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: originalTime, to: now) ?? "1m"
    }
}
