//
//  MessagesViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

class MessagesViewController: UIViewController {

    //MARK: -Properties
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    
    //MARK: -Fucntions
    
    func configureView() -> Void {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Messages"
    }

}
