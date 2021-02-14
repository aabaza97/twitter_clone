//
//  SearchViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 14/02/2021.
//

import UIKit

private let userCellReuseId: String = "userCell"

class SearchViewController: UIViewController {
    //MARK: -Data Properties
    private var users: [User] = [User]()
    
    //MARK: -UI Properties
    private lazy var imgView: UIImageView = {
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        let img = UIImage(systemName: "magnifyingglass", withConfiguration: imgConfig)
        let imgView = UIImageView(image: img)
        imgView.tintColor = .lightGray
        return imgView
    }()
    
    private lazy var searchBar: UITextField = {
        let bar = UITextField()
        let leftView = UIView()
        bar.attributedPlaceholder = NSAttributedString(string: "Search users...", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray
        ])
        bar.backgroundColor = .systemGroupedBackground
        bar.layer.borderColor = UIColor.clear.cgColor
        bar.font = UIFont.systemFont(ofSize: 16)
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 16
        bar.leftViewMode = .always
        bar.leftView = leftView
        bar.autocapitalizationType = .none
        bar.autocorrectionType = .no
        bar.setHeight(32)
        bar.clearButtonMode = .whileEditing
        
        leftView.setDimensions(width: 32, height: 32)
        leftView.addSubview(imgView)
        imgView.center(inView: leftView)
        
        return bar
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var usersTableView: UITableView = {
        let tbl = UITableView()
        
        return tbl
    }()
    
    //MARK: -Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureTableView()
        self.users = self.dummyUsers()
        
    }
    
    
    //MARK: -Selectors
    @objc
    func cancelButtonPressed() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -Functions
    private func configureView() -> Void {
        //View configuration
        self.view.backgroundColor = .white
        
        //NavigationController configuration
        self.configureNavBar()
        self.searchBar.becomeFirstResponder()
    }
    
    private func configureNavBar() -> Void {
        let width = self.view.frame.width - 70
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        self.containerView.frame = .init(x: 0, y: 0, width: width, height: 32)
        self.navigationItem.titleView = containerView
        
        //Adding SubView
        self.containerView.addSubview(searchBar)
        self.view.addSubview(usersTableView)
        
        //Positioning SubViews
        self.searchBar.anchor(left: containerView.leftAnchor, right: containerView.rightAnchor,
                              marginLeft: 8, marginRight: 8)
        self.searchBar.centerY(inView: containerView)
        
        
    }
    
    
    private func configureTableView() -> Void {
        self.usersTableView.backgroundColor = .white
        self.showContentWithAnimation()
        
        self.usersTableView.tableFooterView = UIView()
        
        self.usersTableView.delegate = self
        self.usersTableView.dataSource = self
        self.usersTableView.register(UserSearchTableViewCell.self, forCellReuseIdentifier: userCellReuseId)
    }
    
    private func showContentWithAnimation() -> Void {
        let yPosition = self.view.frame.maxY
        self.usersTableView.frame = self.view.frame
        self.usersTableView.frame.origin.y = yPosition
        
        UIView.animate(withDuration: 0.3) {
            self.usersTableView.frame.origin.y = 0
        }
    }
    
    private func dummyUsers() -> [User] {
        let dummyImageURL = "https://blog.za3k.com/wp-content/uploads/2015/03/default_profile_3.png"
        var users: [User] = [User]()
        
        let d1 = User(userId: "lkajsdfpqoijewf", username: "dummyUser_1", fullname: "Dummy", email: "dummy", image: dummyImageURL)
        let d2 = User(userId: "lkajsdfpqoijewf", username: "dummyUser_2", fullname: "Dummy DUM", email: "dummy", image: dummyImageURL)
        let d3 = User(userId: "lkajsdfpqoijewf", username: "dummyUser_3", fullname: "Dummy D", email: "dummy", image: dummyImageURL)
        let d4 = User(userId: "lkajsdfpqoijewf", username: "dummyUser_4", fullname: "Dummy BOO", email: "dummy", image: dummyImageURL)
        let d5 = User(userId: "lkajsdfpqoijewf", username: "dummyUser_5", fullname: "DummyHurray", email: "dummy", image: dummyImageURL)
        
        users.append(d1)
        users.append(d2)
        users.append(d3)
        users.append(d4)
        users.append(d5)
        
        return users
    }
    
}


//MARK: -EXT(Tableview DataSource)
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellReuseId, for: indexPath) as! UserSearchTableViewCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    
}

//MARK: -EXT(Tableview Delegate)
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32 + 40
    }
}
