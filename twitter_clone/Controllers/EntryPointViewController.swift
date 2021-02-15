//
//  EntryPointViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 15/02/2021.
//

import UIKit

class EntryPointViewController: UIViewController {
    
    //MARK: -Data Members
    private var isLoggedIn: Bool = false
    
    //MARK: -UI Properties
    private lazy var logoImageView: UIImageView = {
        let img = UIImage(named: "TwitterLogo")
        
        let imgView = UIImageView()
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        
        imgView.setDimensions(width: 150, height: 150)
        
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.logoImageView.center = self.view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.checkLoginStatus() {
            DispatchQueue.main.async{
                self.animateViews()
            }
        }
    }
    
    
    //MARK: -Functions
    private func configureView() -> Void {
        //view configurations
        self.view.backgroundColor = .twitterBlue
        
        //adding subviews
        self.view.addSubview(logoImageView)
    }

    
    private func animateViews() -> Void {
        UIView.animate(withDuration: 0.3) {
            let scaledWidth = self.view.frame.size.width * 5 //used width since it's a square
            let diffX = self.view.frame.size.width - scaledWidth
            let diffY = self.view.frame.size.height - scaledWidth
            
            self.logoImageView.frame = CGRect(x: (diffX / 2),
                                              y: (diffY / 2),
                                              width: scaledWidth,
                                              height: scaledWidth)
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.logoImageView.alpha = 0.0
        }, completion: { (done) in
            guard done == true else {return}
            switch self.isLoggedIn {
            case true:
                self.launchMainController()
                break
            case false:
                self.launchLogin()
                break
            }
        })
    }
    
    private func checkLoginStatus(completion: @escaping () -> Void) -> Void {
        AuthManager.shared.checkUserAuthStatusAndLoadData { (error) in
            guard error == nil else { self.isLoggedIn = false; return}
            
            self.isLoggedIn = true
            completion()
        }
    }
    
    private func launchMainController() -> Void {
        let mainController = MainTabbarController()
        mainController.modalPresentationStyle = .fullScreen
        mainController.modalTransitionStyle = .crossDissolve
        
        self.present(mainController, animated: true, completion: nil)
    }
    
    private func launchLogin() -> Void {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        loginScreen.modalTransitionStyle = .crossDissolve
        
        
        self.present(loginScreen, animated: true, completion: nil)
    }
}
