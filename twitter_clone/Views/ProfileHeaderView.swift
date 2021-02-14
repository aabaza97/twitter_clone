//
//  ProfileHeaderView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 12/02/2021.
//

import UIKit

protocol HeaderProfileDelegate: class {
    func backButtonPressed() -> Void
    func filter(by filterOption: FilterOptions) -> Void
}

class ProfileHader: UICollectionReusableView {
    //MARK: -Logic Properties
    public weak var delegate: HeaderProfileDelegate!
    
    public let filterBar = UserProfileTweetsFilterView()
    
    public var viewModel: ProfileHeaderVM! {
        didSet {
            self.setUserInfo()
        }
    }
    
    //MARK: -UI Properties
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, marginTop: 60, marginLeft: 16)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let img = UIImage(systemName: "arrow.left", withConfiguration: imgConfig)
        btn.setImage(img, for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let userProfileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.setDimensions(width: 80, height: 80)
        imgView.layer.cornerRadius = 40
        imgView.layer.borderWidth = 4
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.backgroundColor = .gray
        return imgView
    }()
    
    private lazy var mainProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.layer.borderColor = UIColor.twitterBlue.cgColor
        btn.layer.borderWidth = 1
        btn.setDimensions(width: 100, height: 36)
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(mainProfileButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .gray
        return lbl
    }()
    
    private lazy var bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var followingLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .gray
        return lbl
    }()
    
    private lazy var followersLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .gray
        return lbl
    }()
    
    
    
    private let filterbarUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.setHeight(2.5)
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    //MARK: -Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Selectors
    @objc
    func backButtonPressed() -> Void {
        self.delegate.backButtonPressed()
    }
    
    @objc
    func mainProfileButtonPressed() -> Void {
        switch viewModel.isMe {
        case true:
            //Allow Editting
            break
        case false:
            self.handleFollowingOptions()
            break
        }
    }
    
    
    //MARK: -Functions
    private func configureView() -> Void {
        //View Configurations
        self.backgroundColor = .white
        
        //Filterbar Configurations
        self.filterBar.filterOptions = self.getFilterOptions()
        self.filterBar.delegate = self
        
        //Adding Subviews
        self.addSubview(headerContainer)
        self.addSubview(separatorView)
        self.addSubview(userProfileImage)
        self.addSubview(mainProfileButton)
        self.addSubview(fullNameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(bioLabel)
        self.addSubview(followingLabel)
        self.addSubview(followersLabel)
        self.addSubview(filterBar)
        self.addSubview(filterbarUnderlineView)
        
        //Positioning Subviews
        self.headerContainer.anchor(top: self.topAnchor,
                                    left: self.leftAnchor,
                                    right: self.rightAnchor,
                                    height: 120)
        
        self.userProfileImage.anchor(top: headerContainer.bottomAnchor,
                                     left: self.leftAnchor,
                                     marginTop: -24,
                                     marginLeft: 16)
        self.mainProfileButton.anchor(top: headerContainer.bottomAnchor,
                                      right: self.rightAnchor,
                                      marginTop: 16,
                                      marginRight: 16)
        self.fullNameLabel.anchor(top: self.userProfileImage.bottomAnchor,
                                  left: self.leftAnchor,
                                  marginTop: 5,
                                  marginLeft: 20)
        self.usernameLabel.anchor(top: self.fullNameLabel.bottomAnchor,
                                  left: self.leftAnchor,
                                  marginTop: 2.5,
                                  marginLeft: 20)
        self.bioLabel.anchor(top: self.usernameLabel.bottomAnchor,
                             left: self.leftAnchor,
                             right: self.rightAnchor,
                             marginTop: 8,
                             marginLeft: 20,
                             marginRight: 16)
        self.followingLabel.anchor(top: self.bioLabel.bottomAnchor,
                                   left: self.leftAnchor,
                                   marginTop: 8,
                                   marginLeft: 20)
        self.followersLabel.anchor(top: self.bioLabel.bottomAnchor,
                                   left: self.followingLabel.rightAnchor,
                                   marginTop: 8,
                                   marginLeft: 16)
        self.filterBar.anchor(top: self.followingLabel.bottomAnchor,
                              left: self.leftAnchor,
                              right: self.rightAnchor,
                              marginTop: 5,
                              height: 50)
        self.filterbarUnderlineView.anchor( left: self.leftAnchor,
                                            bottom: self.bottomAnchor,
                                            width: self.frame.width / CGFloat(FilterOptions.allCases.count) )
        self.separatorView.anchor(left: self.leftAnchor,
                                  bottom: self.bottomAnchor,
                                  right: self.rightAnchor,
                                  marginTop: 0)
        
        
    }
    
    private func setUserInfo() -> Void {
        self.fullNameLabel.text = viewModel.fullname
        self.usernameLabel.text = viewModel.username
        self.bioLabel.text = viewModel.bioInfo
        self.followingLabel.attributedText = viewModel.followingInfo
        self.followersLabel.attributedText = viewModel.followersInfo
        self.userProfileImage.sd_setImage(with: viewModel.profileImageURL, completed: nil)
        self.configureMainButton()
    }
    
    private func getFilterOptions() -> [String] {
        var options = [String]()
        for option in FilterOptions.allCases {
            options.append(option.description)
        }
        return options
    }
    
    private func handleFollowingOptions() -> Void {
        let follow = Follow(followerId: GlobalUser.shared.getId(), followeeId: viewModel.profileUserId)
        
        switch viewModel.isFollowing {
        case true:
            FollowManager.shared.follow(follow) { [weak self](error) in
                guard error == nil else {return}
                self?.viewModel.toggleFollowingStatus()
                self?.setUserInfo()
            }
            break
        case false:
            //Show confirmation alert first
            FollowManager.shared.unFollow(follow) { [weak self](error) in
                guard error == nil else {return}
                self?.viewModel.toggleFollowingStatus()
                self?.setUserInfo()
            }
            break
        }
    }
    
    private func configureMainButton() -> Void {
        self.mainProfileButton.setTitle(viewModel.mainButtonTitle, for: .normal)
        self.mainProfileButton.setTitleColor(viewModel.mainButtonTitleColor, for: .normal)
        self.mainProfileButton.backgroundColor = viewModel.mainButtonBackgrounColor
        self.mainProfileButton.layer.borderColor = viewModel.mainButtonBorderColor.cgColor
    }
}


//MARK: -EXT(FilterBar Delegate)
extension ProfileHader: FilterBarDelegate {
    
    func selectOption(_ view: UICollectionView, byItemAt indexPath: IndexPath) {
        guard let filterView = view.cellForItem(at: indexPath) else { return }
        
        let xPosition = filterView.frame.origin.x
        UIView.animate(withDuration: 0.2) {
            self.filterbarUnderlineView.frame.origin.x = xPosition
        }
    }
    
    func filter(by filterOption: FilterOptions) {
        self.delegate.filter(by: filterOption)
    }
    
}
