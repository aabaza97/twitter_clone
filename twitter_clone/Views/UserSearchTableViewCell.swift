//
//  UserSearchTableViewCell.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 14/02/2021.
//

import UIKit

class UserSearchTableViewCell: UITableViewCell {
    
    //MARK: -Data Properties
    public var user: User! {
        didSet {
            bio = "An Engineer who likes to read, write, watch, observe and mutate."
            self.setUserInfo()
        }
    }
    
    private var bio: String!
    
    //MARK: -UI Properties
    private lazy var userProfileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.setDimensions(width: 40, height: 40)
        imgView.layer.cornerRadius = 20
        imgView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        imgView.addGestureRecognizer(tapGesture)
        return imgView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        lbl.addGestureRecognizer(tapGesture)
        return lbl
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        lbl.addGestureRecognizer(tapGesture)
        return lbl
    }()
    
    private lazy var bioInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //MARK: -Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Selectors
    @objc
    func showProfile() -> Void {
        
    }
    
    //MARK: -Functions
    private func configureView() -> Void  {
        let cellMargins: CGFloat = 16
        let imageTextSpacing: CGFloat = 12
        let infoSpacing: CGFloat = 5
        
        //Adding Subviews
        self.addSubview(userProfileImage)
        self.addSubview(fullNameLabel)
        self.addSubview(usernameLabel)
//        self.addSubview(bioInfoLabel)
        
        //Positioning Subviews
        self.userProfileImage.anchor(top: self.topAnchor, left: self.leftAnchor,
                                     marginTop: cellMargins, marginLeft: cellMargins)
        self.fullNameLabel.anchor(top:self.topAnchor, left: self.userProfileImage.rightAnchor, right: self.rightAnchor,
                                  marginTop: cellMargins, marginLeft: imageTextSpacing, marginRight: cellMargins)
        self.usernameLabel.anchor(top:self.fullNameLabel.bottomAnchor, left: self.userProfileImage.rightAnchor, right: self.rightAnchor,
                                  marginTop: infoSpacing, marginLeft: imageTextSpacing, marginRight: cellMargins)
//        self.bioInfoLabel.anchor(top:self.usernameLabel.bottomAnchor, left: self.userProfileImage.rightAnchor, right: self.rightAnchor,
//                                  marginTop: infoSpacing, marginLeft: imageTextSpacing, marginRight: cellMargins)
        
    }
    
    private func setUserInfo() -> Void {
        self.fullNameLabel.text = self.user.fullname
        self.usernameLabel.text = "@" + self.user.username
//        self.bioInfoLabel.text = self.bio
        self.userProfileImage.sd_setImage(with: self.user.getImageURL(), completed: nil)
    }
}
