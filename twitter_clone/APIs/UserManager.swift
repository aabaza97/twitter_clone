//
//  UserManager.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 06/02/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserManager {
    
    //MARK: -Properties
    static let shared = UserManager()
    
    private let colName = "Users"
    
    enum UserManagerError: Error {
        case FailedToSetUserData
    }
    
    //MARK: -CompletionHandlers
     typealias createUserCompletion = (Result<User, Error>) -> Void
    
    //MARK: -Fucntions
    ///Creates New User. Do not specify "userId" nor "image". Returns a User Object on Success.
    public func createNew(from user: User, with password: String, profileImage: Data, completion: @escaping createUserCompletion){
        
        //Authentication
        AuthManager.shared.register(with: user.email, and: password) { (authResult) in
            switch authResult {
            case.success(let id ):
                //Upload User Image Profile
                FileUploadManager.shared.uploadProfileImage(userId: id, imageData: profileImage) { [weak self](uploadResult) in
                    switch uploadResult {
                    case.success(let url):
                        //Set User Firestore Document
                        let newUser = User(userId: id, username: user.username, fullname: user.fullname, email: user.email, image: url)
                        self?.setUserData(for: newUser) { (setDataResult) in
                            switch setDataResult {
                            case.success(_):
                                completion(.success(newUser))
                                break
                            case.failure(let e):
                                completion(.failure(e))
                                break
                            }
                        } //#END Set User Firestore Document
                        break
                    case.failure(let e):
                        completion(.failure(e))
                        break
                    }
                }//#END Upload user Image Profile
                
                break
            case.failure(let e):
                completion(.failure(e))
                break
            }
        }//#END Authentication
    }
    
    func getUser(with userId: String, completion: @escaping (Bool) -> Void) -> Void {
        db.collection(colName).document(userId).getDocument { (snapshot, error) in
            guard let data = snapshot?.data(), error == nil else { completion(false); return }
            GlobalUser.shared.setFrom(doc: data)
            completion(true)
        }
    }
    
    private func setUserData(for user: User, completion: @escaping createUserCompletion) -> Void {
        do {
            try db.collection(colName).document(user.userId).setData(from: user)
            completion(.success(user))
        } catch _ {
            completion(.failure(UserManagerError.FailedToSetUserData))
        }
    }

}
