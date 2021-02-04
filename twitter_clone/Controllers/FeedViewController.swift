//
//  FeedViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

class FeedViewController: UIViewController {

    //MARK: -Properties
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    
    //MARK: -Fucntions

    func configureView() -> Void {
        view.backgroundColor = .white
        
        let imgView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imgView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imgView
    }
}
