//
//  UserProfileViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 12/02/2021.
//

import UIKit

private let tweetReuseId = "tweetCell"
private let headerReuseId = "profileHeader"

class UserProfileViewController: UICollectionViewController {
    
    //MARK: -Logic Properties
    private var tweets: [Tweet] = [Tweet]()
    
    public var user: User!{
        didSet{
            self.fetchTweets()
        }
    }
    
    //MARK: -UI Properties
    
    
    //MARK: -Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isHidden = true
    }

    
    //MARK: -Functions
    private func configureView() -> Void {
        //CollectionView configuration
        self.collectionView.backgroundColor = .white
        self.collectionView.register(TweetCell.self,
                                     forCellWithReuseIdentifier: tweetReuseId)
        self.collectionView.register(ProfileHader.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: headerReuseId)
        self.collectionView.contentInsetAdjustmentBehavior = .never

    }
    
    private func refreshCollectionView() -> Void {
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    
    private func fetchTweets() -> Void {
        self.collectionView.refreshControl?.beginRefreshing()
        TweetManager.shared.fetchTweets(for: self.user) { [weak self](fetchResult) in
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
   
    
    private func fetchTweetsAndReplies() -> Void {
        self.tweets.removeAll()
//        self.collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    private func fetchLikes() -> Void {
        self.tweets.removeAll()
//        self.collectionView.reloadSections(IndexSet(integer: 1), with)
    }
}


//MARK: -EXT(CollectionViewController)
extension UserProfileViewController{
    //Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: ProfileHader = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseId, for: indexPath) as! ProfileHader
    
        headerView.delegate = self
        headerView.viewModel = ProfileHeaderVM(user: self.user)
        
        return headerView
    }
    
    //Items count
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    //Cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tweetCell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetReuseId,
                                                                      for: indexPath) as! TweetCell
        let index: Int = indexPath.row
        
        tweetCell.tweet = self.tweets[index]
        
        return tweetCell
    }
}


//MARK: -EXT(FlowLayoutDelegate)
extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 353)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tweetVM = TweetVM(tweet: tweets[indexPath.row])
        let width = self.view.frame.width
        return CGSize(width: width,
                      height: tweetVM.getTweetHeight(for: width))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


//MARK: -EXT(TweetCellDelegate)
extension UserProfileViewController: HeaderProfileDelegate {
    func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func filter(by filterOption: FilterOptions) {
        switch filterOption {
        case .likes:
            self.fetchLikes()
            break
        case.replies:
            self.fetchTweetsAndReplies()
            break
        case.tweets:
            self.fetchTweets()
            break
        }
    }
}

