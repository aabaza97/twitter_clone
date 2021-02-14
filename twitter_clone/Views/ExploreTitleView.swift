//
//  ExploreTitleView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 13/02/2021.
//

import UIKit

class ExploreTitleView: UIView {
    
    //MARK: -Properties
    let imgView: UIImageView = {
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        let img = UIImage(systemName: "magnifyingglass", withConfiguration: imgConfig)
        let imgView = UIImageView(image: img)
        imgView.tintColor = .lightGray
        return imgView
    }()
    
    let hintLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Search Twitter"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.setHeight(32)
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(imgView)
        view.addSubview(hintLabel)
        
        imgView.anchor(left: view.leftAnchor, right: hintLabel.leftAnchor, marginLeft: 50 , marginRight: 5)
        imgView.centerY(inView: view)
        hintLabel.anchor(left: imgView.rightAnchor, right: view.rightAnchor, marginLeft: 5, marginRight: 50)
        hintLabel.centerY(inView: view)
        
        return view
    }()
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    //MARK: -Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    private func configureView() -> Void {
        //Adding Subviews
        self.addSubview(containerView)
        containerView.center(inView: self)
    }
    
}


