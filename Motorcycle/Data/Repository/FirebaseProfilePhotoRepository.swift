//
//  FirebaseProfilePhotoRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class FirebaseProfilePhotoRepository: ProfilePhotoRepository {
    
    private let storage = Storage.storage()
    private let db = Firestore.firestore()

    // Upload a profile photo to Firebase Storage
    func uploadProfilePhoto(_ image: UIImage) -> AnyPublisher<URL, Error> {
        return Future { promise in
            // Generate a unique filename for the profile photo
            let filename = "\(UUID().uuidString).jpg"

            // Reference to the Firebase Storage bucket where you want to store profile photos
            let storageRef = self.storage.reference().child("profile_photos").child(filename)

            if let imageData = image.jpegData(compressionQuality: 0.5) {
                // Upload the image data to Firebase Storage
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"

                _ = storageRef.putData(imageData, metadata: metadata) { _, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        // Successfully uploaded the profile photo
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                promise(.failure(error))
                            } else if let downloadURL = url {
                                promise(.success(downloadURL))
                            }
                        }
                    }
                }
            } else {
                // Failed to convert the image to data
                promise(.failure(ProfilePhotoError.imageConversionError))
            }
        }
        .eraseToAnyPublisher()
    }

    // Delete the user's profile photo from Firebase Storage
    func deleteProfilePhoto(_ imageURL: URL) -> AnyPublisher<Void, Error> {
        // Create a storage reference for the image URL
        let storageRef = storage.reference(forURL: imageURL.absoluteString)

        return Future<Void, Error> { promise in
            // Delete the photo and handle success or failure
            storageRef.delete { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func updateProfilePhotoURL(_ photoURL: URL) -> AnyPublisher<Void, Error> {
        guard let userId = Auth.auth().currentUser?.uid else {
            // Return an error if there's no authenticated user
            return Fail<Void, Error>(error: FirebaseUserRepositoryError.userNotAuthenticated)
                .eraseToAnyPublisher()
        }

        let userRef = db.collection("users").document(userId)

        return Future<Void, Error> { promise in
            userRef.updateData(["profilePhotoURL": photoURL.absoluteString]) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

