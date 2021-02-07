//
//  MainTabbarController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

class MainTabbarController: UITabBarController {

    //MARK: -Logic Properites
    var floatingButtonAction = FloatingButtonAction.main.action
    
    //MARK: -UI Properties
    let floatingActionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = . white
        btn.backgroundColor = .twitterBlue
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.layer.cornerRadius = 56/2
        btn.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    
    
    //MARK: -Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .twitterBlue
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLoginStatus()
    }
    
    
    
    //MARK: -Functions
    func checkLoginStatus() -> Void {
        AuthManager.shared.checkUserAuthStatus { [weak self](result) in
            switch result {
            case.success(_):
                self?.configureTabbarController()
                self?.configureView()
                break
            case.failure(_):
                //user is not logged in
                DispatchQueue.main.async {
                    let nav = UINavigationController(rootViewController: LoginViewController())
                    nav.modalPresentationStyle = .fullScreen
                    self?.present(nav, animated: true, completion: nil)
                }
                break
            }
        }
    }
    
    func configureView() -> Void {
        self.view.addSubview(floatingActionButton)
        self.floatingActionButton.anchor( bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     right: self.view.safeAreaLayoutGuide.rightAnchor,
                                     marginBottom: 64,
                                     marginRight: 16,
                                     width: 56,
                                     height: 56)
    }

    func configureTabbarController() -> Void {
        let home = setupNavController(with: FeedViewController(), and: UIImage(systemName: "house") )
        let search = setupNavController(with: SearchViewController(), and: UIImage(systemName: "magnifyingglass") )
        let notifications = setupNavController(with: NotificationsViewController(), and: UIImage(systemName: "bell") )
        let messages = setupNavController(with: MessagesViewController(), and: UIImage(systemName: "envelope") )
        
        self.viewControllers = [home, search, notifications, messages]
        self.tabBar.tintColor = .twitterBlue
    }
    
    func setupNavController(with controller: UIViewController, and image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    //MARK: -Selectors
    @objc func actionButtonPressed() -> Void {
        
    }
}
