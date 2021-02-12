//
//  FeedViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

private let tweetReuseId = "tweetCell"

class FeedViewController: UICollectionViewController {
    
    //MARK: -Logic Properties
    private var tweets: [Tweet] = [Tweet]()

    //MARK: -UI Properties
    private let refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.tintColor = .twitterBlue
        refresher.attributedTitle = NSAttributedString(string: "Hearing the wistles...",
                                                       attributes: [
                                                        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
                                                        NSAttributedString.Key.foregroundColor : UIColor.gray
                                                       ])
        return refresher
    }()
    
    private lazy var sideMenuButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        btn.tintColor = .twitterBlue
        btn.addTarget(self, action: #selector(toggleSideMenu), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.fetchTweets()
    }
    
    
    
    //MARK: -Selectors
    @objc func toggleSideMenu() -> Void {
        print("SideMenu toggled!!")
    }
    
    
    @objc private func fetchTweets() -> Void {
        self.collectionView.refreshControl?.beginRefreshing()
        TweetManager.shared.fetchTweets { [weak self](fetchResult) in
            switch fetchResult{
            case.success(let tweets):
                //Load Tweets in Feed
                self?.tweets = tweets
                self?.refreshCollectionView()
                break
            case.failure(_):
                //Show Error Alert
                break
            }
        }
    }
    
    //MARK: -Fucntions

    func configureView() -> Void {
        self.view.backgroundColor = .white
        
        //RefreshControl configuration

        self.refreshControl.addTarget(self, action: #selector(fetchTweets), for: .valueChanged)
        
        //CollectionView configuration
        self.collectionView.backgroundColor = .white
        self.collectionView.register(TweetCell.self, forCellWithReuseIdentifier: tweetReuseId)
        self.collectionView.refreshControl = self.refreshControl
        
        //Navigation bar configuration
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sideMenuButton)
        
        let imgView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imgView.setDimensions(width: 42, height: 42)
        imgView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imgView
        
    }
    
    
    private func refreshCollectionView() -> Void {
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}


//MARK: - EXT(CollectionViweDelegate)
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tweetCell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetReuseId,
                                                                      for: indexPath) as! TweetCell
        let index: Int = indexPath.row
        
        tweetCell.tweet = self.tweets[index]
        
        return tweetCell
    }
}


//MARK: -EXT(FlowLayoutDelegate)
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
