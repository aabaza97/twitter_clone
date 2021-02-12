//
//  TweetTextView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 11/02/2021.
//

import UIKit

class TweetTextView: UITextView {
    
    //MARK: -Logic Properties
    
    

    //MARK: -UI Properties
    private let placeHolderLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "What is happening?"
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 17)
        return lbl
    }()
    
    private let userProfileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.setDimensions(width: 50, height: 50)
        imgView.layer.cornerRadius = 25
        return imgView
    }()
    
    
    //MARK: -Inits
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.becomeFirstResponder()
        self.configureView()
        self.configurePlaceholderObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Selectors
    @objc func togglePlaceHolder() -> Void {
        self.placeHolderLabel.isHidden = !self.text.isEmpty
    }
    
    
    //MARK: -Functions
    private func configureView() -> Void {
        self.backgroundColor = .white
        self.font = UIFont.systemFont(ofSize: 17)
        self.isScrollEnabled = true
        self.textContainerInset = UIEdgeInsets(top: 24, left: 30 + 50, bottom: 0, right: 16)
        
        self.addSubview(self.userProfileImageView)
        self.addSubview(self.placeHolderLabel)
        self.userProfileImageView.anchor(top: self.topAnchor,
                                         left: self.leftAnchor,
                                         marginTop: 16,
                                         marginLeft: 16)
        self.placeHolderLabel.anchor(top: self.topAnchor,
                                     left: self.userProfileImageView.rightAnchor,
                                     marginTop: 24,
                                     marginLeft: 16)
    }
    
    private func configurePlaceholderObserver() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(togglePlaceHolder), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    func setImage(from imgURL: URL) -> Void {
        self.userProfileImageView.sd_setImage(with: imgURL, completed: nil)
    }
}
