//
//  TrendingCollectionViewCell.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 16/02/2021.
//

import UIKit

class TrendingCell: UICollectionViewCell {
    
    //MARK: -UI Properties

    private lazy var headLocation: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15, weight: .medium)
        lbl.textColor = .lightGray
        lbl.text = "Trending in Egypt"
        return lbl
    }()
    
    private lazy var hashTag: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.text = "#تأجيلـالامتحانات"
        return lbl
    }()
    
    private lazy var numberOfRetweets: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.text = "14.3K Tweets"
        return lbl
    }()
    
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(scale: .medium)
        btn.setImage(UIImage(systemName: "ellipsis", withConfiguration: imgConfig), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    //MARK: -inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Selectors
    @objc
    func actionButtonPressed() -> Void {
        print("Action button Pressed.....")
    }
    
    //MARK: -Functions
    private func configureView() -> Void {
        //View configuration
        self.backgroundColor = .white
        
        //Adding subviews
        self.addSubview(actionButton)
        self.addSubview(headLocation)
        self.addSubview(hashTag)
        self.addSubview(numberOfRetweets)
        self.addSubview(separatorView)
        
        //positioning subviews
        self.actionButton.anchor(
            top: self.topAnchor,
            right: self.rightAnchor,
            marginTop: 16,
            marginRight: 16
        )
        self.headLocation.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            marginTop: 16,
            marginLeft: 16
        )
        self.hashTag.anchor(
            top: self.headLocation.bottomAnchor,
            left: self.leftAnchor,
            marginTop: 5,
            marginLeft: 16
        )
        self.numberOfRetweets.anchor(
            top: self.hashTag.bottomAnchor,
            left: self.leftAnchor,
            marginTop: 5,
            marginLeft: 16
        )
        
        self.separatorView.anchor(
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            marginTop: 5
        )
    }
}
