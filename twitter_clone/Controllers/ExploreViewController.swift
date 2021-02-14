//
//  SearchViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

class ExploreViewController: UIViewController {

    //MARK: -Properties
    
    private lazy var sideMenuButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(weight: .bold)
        let img = UIImage(systemName: "line.horizontal.3", withConfiguration: imgConfig)
        btn.setImage(img , for: .normal)
        btn.tintColor = .twitterBlue
        btn.addTarget(self, action: #selector(toggleSideMenu), for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingsButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(weight: .bold)
        let img = UIImage(systemName: "gearshape", withConfiguration: imgConfig)
        btn.setImage(img , for: .normal)
        btn.tintColor = .twitterBlue
        btn.addTarget(self, action: #selector(toggleSideMenu), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleView: UIView = {
        let view = ExploreTitleView()
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchViewPressed))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    //MARK: -Selectors
    @objc func toggleSideMenu() -> Void {
        print("SideMenu toggled!!")
    }
    @objc func searchViewPressed() -> Void {
        let searchController = SearchViewController()
        self.navigationController?.pushViewController(searchController, animated: false)
    }
    
    //MARK: -Fucntions
    
    func configureView() -> Void {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Explore"
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.titleView = titleView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sideMenuButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
    }

}
