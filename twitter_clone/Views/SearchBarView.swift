//
//  SearchBarView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 14/02/2021.
//

import UIKit

class twitterSearchBar: UIView, UITextFieldDelegate {
    
    let searchBar: UITextField
    

    init(customSearchBar: UITextField) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)

        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemGroupedBackground
        searchBar.returnKeyType = .done
        searchBar.setHeight(32)
        searchBar.layer.cornerRadius = 16
        searchBar.clipsToBounds = true
        addSubview(searchBar)
    }
    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UITextField())
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
}
