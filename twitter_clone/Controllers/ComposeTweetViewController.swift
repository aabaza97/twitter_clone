//
//  ComposeTweetViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 11/02/2021.
//

import UIKit
import SDWebImage

class ComposeTweetViewController: UIViewController {

    //MARK: - Logic Properties
    
    
    //MARK: - UI Properties
    private lazy var tweetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        btn.layer.cornerRadius = 16
        
        btn.addTarget(self, action: #selector(sendTweet), for: .touchUpInside)
        return btn
    }()
    
    private lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(cancelNewTweet), for: .touchUpInside)
        return btn
    }()
    
    private let userProfileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.setDimensions(width: 50, height: 50)
        imgView.layer.cornerRadius = 25
        return imgView
    }()
    
    private let tweetTextView = TweetTextView()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    //MARK: - Actions
    
    
    //MARK: - Selectors
    @objc func cancelNewTweet() -> Void{
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func sendTweet() -> Void {
        guard let tweetText = tweetTextView.text else { return }
        let currentTimeStamp = Date().timeIntervalSince1970
        
        let newTweet = Tweet(text: tweetText, userId: GlobalUser.shared.getId(), timeStamp: currentTimeStamp)
        
        TweetManager.shared.createTweet(newTweet) { [weak self](createResult) in
            switch createResult {
            case.success(_):
                //Show progress Indicator Later on using JGProgressIndicator
                print("Tweet was sent Successfully with ID: (\(newTweet.getId())")
                self?.cancelNewTweet()
                break
            case.failure(_):
                print("Oops Something went wront")
                //Show Alert Later with error message!
                break
            }
        }
    }
    
    //MARK: - Functions
    
    func configureView() -> Void {
        self.view.backgroundColor = .white
        
        //Navigation bar configuration
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
        
        //Controls configuration
        self.view.addSubview(tweetTextView)
        self.tweetTextView.setHeight(300)
        self.tweetTextView.anchor(top: self.view.topAnchor,
                                     left: self.view.leftAnchor,
                                     right: self.view.rightAnchor,
                                     marginTop: 0,
                                     marginLeft: 0,
                                     marginRight: 0)
        self.tweetTextView.setImage(from: GlobalUser.shared.getImageURL())
    }

}
