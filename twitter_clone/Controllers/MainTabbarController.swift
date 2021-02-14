//
//  MainTabbarController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

class MainTabbarController: UITabBarController {

    //MARK: -Logic Properites
    var floatingButtonAction: String = FloatingButtonAction.main.action
    
    //MARK: -UI Properties
    private lazy var floatingActionButton: UIButton = {
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
        self.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLoginStatus()
    }
    
    
    //MARK: -Selectors
    @objc func actionButtonPressed() -> Void {
        switch floatingButtonAction {
        case FloatingButtonAction.main.action:
            self.openTweetComposer()
            break
        default:
            break
        }
    }
    
    
    //MARK: -Functions
    private func configureView() -> Void {
        //Tabbar configuration
        self.configureTabbarController()
        
        //Floating action button configuration
        self.view.addSubview(floatingActionButton)
        self.floatingActionButton.anchor( bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     right: self.view.safeAreaLayoutGuide.rightAnchor,
                                     marginBottom: 64,
                                     marginRight: 16,
                                     width: 56,
                                     height: 56)
    }

    private func configureTabbarController() -> Void {
        //Tabbar configurations
        self.tabBar.isHidden = false
        self.tabBar.tintColor = .twitterBlue
        self.tabBar.isTranslucent = false
        
        //Adding TabItems
        let imgConfig = UIImage.SymbolConfiguration(weight: .medium)
        let home = setupNavControllerForTabbarItem(with: FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()),
                                                   and: UIImage(systemName: "house.fill", withConfiguration: imgConfig))
        
        let search = setupNavControllerForTabbarItem(with: ExploreViewController(),
                                                     and: UIImage(systemName: "magnifyingglass", withConfiguration: imgConfig))
        
        let notifications = setupNavControllerForTabbarItem(with: NotificationsViewController(),
                                                            and: UIImage(systemName: "bell", withConfiguration: imgConfig))
        
        let messages = setupNavControllerForTabbarItem(with: MessagesViewController(),
                                                       and: UIImage(systemName: "envelope", withConfiguration: imgConfig))
        
        self.viewControllers = [home, search, notifications, messages]
        
    }
    
    ///Sets up a UINavigationController for a UIViewController with a TabbarItem image.
    private func setupNavControllerForTabbarItem(with controller: UIViewController, and image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    func checkLoginStatus() -> Void {
        AuthManager.shared.checkUserAuthStatus { [weak self](result) in
            switch result {
            case.success(let userId):
                UserManager.shared.getMyUser(with: userId) { (getResult) in
                    switch getResult {
                    case true :
                        self?.configureView()
                        break
                    case false:
                        self?.launchLogin()
                        break
                    }
                }
                break
            case.failure(_):
                //user is not logged in
                self?.launchLogin()
                break
            }
        }
    }
    
    private func logOut() -> Void {
        AuthManager.shared.logOut { [weak self](result) in
            switch result {
            case true:
                self?.checkLoginStatus()
                break
            case false:
                break
            }
        }
    }
    
    private func openTweetComposer() -> Void {
        let nav = UINavigationController(rootViewController: ComposeTweetViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    private func launchLogin() -> Void {
        DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
}
