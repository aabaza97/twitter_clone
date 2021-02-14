//
//  FilterButtonView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 13/02/2021.
//

import UIKit

class FilterButtonView: UICollectionViewCell {
    
    //MARK: -Logic Properties
    public var titleText: String! {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.hilightSelected(0.2)
        }
    }
    

    //MARK: -UI Properties
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .center
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
        self.backgroundColor = .white
        
        //Adding subviews
        self.addSubview(titleLabel)
        
        //Subviews configuration
        self.titleLabel.center(inView: self)
    }
    
    private func hilightSelected(_ duration: TimeInterval) -> Void {
        UIView.animate(withDuration: duration) {
            self.titleLabel.font = self.isSelected ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 15)
            self.titleLabel.textColor = self.isSelected ? UIColor.twitterBlue : UIColor.gray
        }
    }
}
