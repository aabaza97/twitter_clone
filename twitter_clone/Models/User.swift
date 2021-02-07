//
//  User.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 06/02/2021.
//

import Foundation

struct User: Codable {
    var userId: String
    var username: String
    var fullname: String
    var email: String
    var image: String
}

class GlobalUser {
    
    static let shared = GlobalUser()
    
    private var userId: String
    private var username: String
    private var fullname: String
    private var email: String
    private var image: String
    
    private init () {
        self.userId = ""
        self.username = ""
        self.email = ""
        self.fullname = ""
        self.image = ""
    }
    
    //MARK: -Getters
    func getId() -> String {
        return self.userId
    }
    func getUsername() -> String {
        return self.username
    }
    func getName() -> String {
        return self.fullname
    }
    func getEmail() -> String {
        return self.email
    }
    func getImageURL() -> String {
        return self.image
    }
    
    //MARK: -Setters
    func setID(_ id:String) -> Void {
        self.userId = id
    }
    func setUsername(_ name: String) -> Void {
        self.username = name
    }
    func setFullNmae(_ name: String) -> Void {
        self.fullname = name
    }
    func setEmail(_ name: String) -> Void {
        self.username = name
    }
    func setImage(_ url: String) -> Void {
        self.image = url
    }
    func set(from user: User) -> Void {
        self.userId = user.userId
        self.username = user.username
        self.email = user.email
        self.fullname = user.fullname
        self.image = user.image
    }
    func setFrom(doc: [String : Any]) -> Void {
        self.userId = doc["userId"] as! String
        self.username = doc["username"] as! String
        self.fullname = doc["fullname"] as! String
        self.email = doc["email"] as! String
        self.image = doc["image"] as! String
    }
    
}
