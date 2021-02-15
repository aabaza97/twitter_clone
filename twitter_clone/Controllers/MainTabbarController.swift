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
        self.configureView()
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
        
        let contollers: [UIViewController] = [
            FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()),
            ExploreViewController(collectionViewLayout: UICollectionViewFlowLayout()),
            NotificationsViewController(),
            MessagesViewController()
        ]
        
        let icons: [UIImage?] = [
            UIImage(systemName: TabIcons.home.name, withConfiguration: imgConfig),
            UIImage(systemName: TabIcons.explore.name, withConfiguration: imgConfig),
            UIImage(systemName: TabIcons.notification.name, withConfiguration: imgConfig),
            UIImage(systemName: TabIcons.messages.name, withConfiguration: imgConfig)
        ]
        
        self.viewControllers = UIComponents.shared.setupTabbarItemsWithNavigation(for: contollers, with: icons)
        
    }
    
    private func logOut() -> Void {
        AuthManager.shared.logOut { (result) in
            switch result {
            case true:

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
}

//MARK: -Ext(UITabbarController Delegate)
extension MainTabbarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let imgConfig = UIImage.SymbolConfiguration(weight: .bold)
        tabBar.selectedItem?.selectedImage = item.image!.withConfiguration(imgConfig)
    }
}
