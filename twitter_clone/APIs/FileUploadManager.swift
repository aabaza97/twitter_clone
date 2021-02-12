//
//  FileUploadManager.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 07/02/2021.
//

import Firebase

class FileUploadManager {
    //MARK: -Properties
    static let shared = FileUploadManager()
    
    private let profileImagesLocation = storageRef.child("user_profile_images")
    
    enum FileUploadManagerError: Error {
        case FailedToUpload
    }
    
    //MARK: -Completion Handlers
    typealias uploadProfileImageCompletion = (Result<String, FileUploadManagerError>)-> Void
    
    //MARK: -Functions
    ///Uploads a user image to the profile images location in the database. Returns the uploaded image URL as String.
    func uploadProfileImage(userId: String, imageData: Data, completion: @escaping uploadProfileImageCompletion) -> Void {
        let fileName = userId + "_" + NSUUID().uuidString + ".png"
        let locationRef = profileImagesLocation.child(userId).child(fileName)
        
        locationRef.putData(imageData, metadata: nil) { (_, error) in
            guard error == nil else { completion(.failure(.FailedToUpload)); return }
        
            locationRef.downloadURL { (url, error) in
                guard let imgUrl = url, error == nil else { completion(.failure(.FailedToUpload)); return }
                //Success
                completion(.success(imgUrl.absoluteString))
            }
        }
    }
    
}
