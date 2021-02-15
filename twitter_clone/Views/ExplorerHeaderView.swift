//
//  ExplorerHeaderView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 15/02/2021.
//

import UIKit

class ExploreHeaderView: UICollectionReusableView {
    
    //MARK: - UI Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private lazy var imgView: UIImageView = {
        let imgview = UIImageView()
        imgview.contentMode = .scaleAspectFit
        imgview.clipsToBounds = true
        imgview.image = #imageLiteral(resourceName: "twitter_logo_blue")
        imgview.alpha = 0.7
        
        return imgview
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        lbl.numberOfLines = 0
        lbl.text = "Breaking News!"
        return lbl
    }()
    
    private lazy var subHeadingLable: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.numberOfLines = 1
        lbl.text = "I don't care about news..."
        return lbl
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
    
    
    
    //MARK: -Functions
    private func configureView() -> Void {
        self.backgroundColor = .lightGray
        //adding subviews
        self.addSubview(imgView)
        self.addSubview(titleLabel)
        self.addSubview(subHeadingLable)
        
        //positioning subviews
        self.imgView.anchor(top: self.topAnchor,
                            left: self.leftAnchor,
                            bottom: self.bottomAnchor,
                            right: self.rightAnchor)
        self.titleLabel.anchor(left: self.leftAnchor,
                               bottom: self.bottomAnchor,
                               right: self.rightAnchor,
                               marginLeft: 16,
                               marginBottom: 16)
        self.subHeadingLable.anchor(left: self.leftAnchor,
                                    bottom: self.titleLabel.topAnchor,
                                    right: self.rightAnchor,
                                    marginLeft: 16,
                                    marginBottom: 5)
    }
}
