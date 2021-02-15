//
//  AuthManager.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 06/02/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

class AuthManager {
    
    //MARK: -Properties
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    enum AuthError: Error {
        case FailedToSignUp
        case FailedToLogIn
        case FailedToLoginAndLoad
        
        var description: String {
            switch self {
            case .FailedToLogIn: return "FailedToLogIn"
            case .FailedToSignUp: return "FailedToSignUp"
            case .FailedToLoginAndLoad: return "FailedToLoginAndLoad"
            }
        }
        
    }
    
    //MARK: -Completion Handlers
    typealias authCompletionHandler = (Result<String, AuthError>) -> Void
    typealias checkAuthStatusCompletionHandler = (Result<String, AuthError>) -> Void
    typealias signOutCompletionHanlder = (Bool) -> Void
    
    //MARK: -Functions
    
    public func register(with email: String, and password: String,  completion: @escaping authCompletionHandler) -> Void{
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            guard let authResult = authResult, error == nil else {
                completion(.failure(.FailedToSignUp))
                return
            }
            
            completion(.success(authResult.user.uid))
        }
    }
    
    public func login(with email: String ,and password: String, completion: @escaping authCompletionHandler ) -> Void {
        auth.signIn(withEmail: email, password: password) { (authResult, error) in
            guard let authResult = authResult, error == nil else {completion(.failure(.FailedToLogIn)); return}
            UserManager.shared.getMyUser(with: authResult.user.uid) { (getResult) in
                switch getResult {
                case true:
                    completion(.success(authResult.user.uid))
                    break
                case false:
                    completion(.failure(.FailedToLogIn))
                    break
                }
            }
            
        }
    }
    
    public func checkUserAuthStatus(completion: @escaping checkAuthStatusCompletionHandler){
        guard let userId = auth.currentUser?.uid else {
            completion(.failure(.FailedToLogIn))
            return
        }
        
        completion(.success(userId))
    }
    
    public func checkUserAuthStatusAndLoadData(completion: @escaping (AuthError?) -> Void){
        self.checkUserAuthStatus { (authResult) in
            switch authResult {
            case.success(let userId):
                UserManager.shared.getMyUser(with: userId) { (getResult) in
                    switch getResult {
                    case true :
                        // loaded user's data successfully
                        completion(nil)
                        break
                    case false:
                        // failed to load user's data
                        completion(.FailedToLoginAndLoad)
                        break
                    }
                }
                break
            case.failure(_):
                completion(.FailedToLogIn)
                break
            }
        }
    }
    
    public func logOut(completion: @escaping signOutCompletionHanlder) -> Void  {
        do {
            try auth.signOut()
            completion(true)
        } catch _ {
            completion(false)
        }
    }
}
