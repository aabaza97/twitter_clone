//
//  RegistrationViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 04/02/2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: -Logic Properties

    
    //MARK: -UI Properties
    
    private let logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = #imageLiteral(resourceName: "TwitterLogo")
        return imgView
    }()
    
    private lazy var emailView: UIView = {
        let img = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let txt = UIElements.shared.createTextField(with: "Email", placeholderColor: .white, textColor: .white)
        let view = UIElements.shared.createContainerViewForInput(with: img, and: txt)
        return view
    }()
    
    private lazy var passwordView: UIView = {
        let img = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let txt = UIElements.shared.createTextField(with: "Password", placeholderColor: .white, textColor: .white)
        txt.isSecureTextEntry = true
        let view = UIElements.shared.createContainerViewForInput(with: img, and: txt)
        return view
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.backgroundColor = .white
        btn.setHeight(50)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let controlFlowButton: UIButton = {
        let btn = UIElements.shared.createAttrStrButton(thin: "Do not have an account?", bold: " Create New")
        btn.addTarget(self, action: #selector(controlFlowPressed), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    //MARK: -Selectors
    @objc private func loginButtonPressed() -> Void {
        print("Loging you in..")
    }
    
    @objc private func controlFlowPressed() -> Void {
        
    }
    
    //MARK: -Functions
    
    func configureView() -> Void {
        self.view.backgroundColor = .twitterBlue
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
        
        //LOGO
        self.view.addSubview(logoImageView)
        logoImageView.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        logoImageView.setDimensions(width: 120, height: 120)
        
        //UIElements
        let stackView = UIStackView(arrangedSubviews: [emailView, passwordView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        stackView.anchor(top: logoImageView.bottomAnchor,
                         left: self.view.safeAreaLayoutGuide.leftAnchor,
                         right: self.view.safeAreaLayoutGuide.rightAnchor,
                         marginLeft: 32,
                         marginRight: 32)
        
        self.view.addSubview(controlFlowButton)
        controlFlowButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor)
        controlFlowButton.centerX(inView: self.view)
    }
    
    
}
