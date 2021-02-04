//
//  FloatingButtonActions.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import Foundation
enum FloatingButtonAction: String {
    case main
    case message
    
    var action: String {
        switch self {
        case .main:
            return "Main"
        case.message:
            return "Message"
        }
    }
    
    
}
