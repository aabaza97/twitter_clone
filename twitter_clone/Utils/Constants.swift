//
//  Constants.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 07/02/2021.
//

import Firebase


//Storage References
let storageRef = Storage.storage().reference()

//Firestore Reference
let db = Firestore.firestore()



enum TabIcons: String, CustomStringConvertible {
    case home
    case explore
    case notification
    case messages
    
    var name: String {
        switch self {
        case .home: return "house.fill"
        case .explore: return "magnifyingglass"
        case .notification: return "bell"
        case .messages: return "envelope"
        }
    }
    
    var description: String {
        switch self {
        case .home: return "home.fill"
        case .explore: return "magnifyingglass"
        case .notification: return "bell"
        case .messages: return "envelope"
        }
    }
    
}
