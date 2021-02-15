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
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let profileImageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.setDimensions(width: 120, height: 120)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(choseProfilePicture), for: .touchUpInside)
        btn.layer.cornerRadius = 120 / 2
        btn.clipsToBounds = true
        return btn
    }()
    
    private lazy var emailView: UIView = {
        let img = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let txt = txtEmail
        txt.keyboardType = .emailAddress
        let view = UIComponents.shared.createContainerViewForInput(with: img, and: txt)
        return view
    }()
    
    private lazy var txtEmail: UITextField = {
        let txt = UIComponents.shared.createTextField(with: "Email", placeholderColor: .white, textColor: .white)
        txt.textContentType = .emailAddress
        return txt
    }()
    
    private lazy var passwordView: UIView = {
        let img = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let txt = txtPassword
        txt.isSecureTextEntry = true
        let view = UIComponents.shared.createContainerViewForInput(with: img, and: txt)
        return view
    }()
    
    private lazy var txtPassword: UITextField = {
        let txt = UIComponents.shared.createTextField(with: "Password", placeholderColor: .white, textColor: .white)
        txt.isSecureTextEntry = false
        txt.delegate = self
        return txt
    }()
    
    private lazy var usernameView: UIView = {
        let img = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let text = txtUsername
        let view = UIComponents.shared.createContainerViewForInput(with: img, and: text)
        return view
    }()
    
    private lazy var txtUsername: UITextField = {
        let txt = UIComponents.shared.createTextField(with: "Username", placeholderColor: .white, textColor: .white)
        txt.textContentType = .name
        return txt
    }()
    
    private lazy var nameView: UIView = {
        let img = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let text = txtName
        let view = UIComponents.shared.createContainerViewForInput(with: img, and: text)
        return view
    }()
    
    private lazy var txtName: UITextField = {
        let txt = UIComponents.shared.createTextField(with: "FullName", placeholderColor: .white, textColor: .white)
        txt.textContentType = .name
        return txt
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.backgroundColor = .white
        btn.setHeight(50)
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let controlFlowButton: UIButton = {
        let btn = UIComponents.shared.createAttrStrButton(thin: "Already have an account?", bold: " Log In")
        btn.addTarget(self, action: #selector(controlFlowPressed), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    //MARK: -Selectors
    @objc private func signUpButtonPressed() -> Void {
        //Handle Registration Here
        
        guard let email = txtEmail.text else { return }
        guard let password = txtPassword.text else { return }
        guard let username = txtUsername.text?.lowercased() else { return }
        guard let fullname = txtName.text else { return }
        guard let profileImage = profileImage?.pngData() else { return }
        
        let userCredentials = AuthCredential(username: username, email: email, fullname: fullname, password: password)
        
        UserManager.shared.createNew(from: userCredentials ,profileImage: profileImage) { [weak self](result) in
            switch result {
            case.success(let newUser):
                GlobalUser.shared.set(from: newUser)
                
                self?.navigationController?.dismiss(animated: true, completion: nil)
                let main = MainTabbarController()
                main.modalPresentationStyle = .fullScreen
                main.modalTransitionStyle = .crossDissolve
                self?.present(main, animated: true)
                
                break
            case.failure(_):
                print("Error: Failed to Create New Account")
                break
            }
        }
    }
    
    @objc private func controlFlowPressed() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func choseProfilePicture() -> Void {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: -Functions
    
    func configureView() -> Void {
        self.view.backgroundColor = .twitterBlue
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
        
        //DELEGATES
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //ImagePickerButton
        self.view.addSubview(profileImageButton)
        self.profileImageButton.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)

        
        //Controls
        let stackView = UIStackView(arrangedSubviews: [nameView, usernameView, emailView, passwordView, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        stackView.anchor(top: profileImageButton.bottomAnchor,
                         left: self.view.safeAreaLayoutGuide.leftAnchor,
                         right: self.view.safeAreaLayoutGuide.rightAnchor,
                         marginTop: 32,
                         marginLeft: 32,
                         marginRight: 32)
        
        self.view.addSubview(controlFlowButton)
        controlFlowButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor)
        controlFlowButton.centerX(inView: self.view)
    }
}


extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImg = info[.editedImage] as? UIImage else { return }
        //Add Edit bottom view once a picture is selected only once
        if self.profileImage == nil { self.addBottomView() }
        
        self.profileImage = profileImg
        self.profileImageButton.setImage(profileImg.withRenderingMode(.alwaysOriginal), for: .normal)
        self.profileImageButton.layer.borderWidth = 1
        self.profileImageButton.layer.borderColor = UIColor.white.cgColor
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBottomView() -> Void {
        let view = UIView()
        let lbl = UILabel()
        
        lbl.text = "Edit"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 16)
        
        view.backgroundColor = .init(white: 0, alpha: 0.5)
        view.setHeight(32)
        
        view.addSubview(lbl)
        lbl.center(inView: view)
        
        self.profileImageButton.addSubview(view)
        view.anchor( left: profileImageButton.leftAnchor,
                     bottom: profileImageButton.bottomAnchor,
                     right: profileImageButton.rightAnchor)
    }
}


extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.txtPassword && !self.txtPassword.isSecureTextEntry){
            self.txtPassword.isSecureTextEntry = true
        }
        return true
    }
}
