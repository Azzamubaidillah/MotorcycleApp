//
//  FirebaseProfilePhotoRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import FirebaseStorage
import Combine

class FirebaseProfilePhotoRepository: ProfilePhotoRepository {
    private let storage = Storage.storage()

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

                _ = storageRef.putData(imageData, metadata: metadata) { (_, error) in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        // Successfully uploaded the profile photo
                        storageRef.downloadURL { (url, error) in
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
    func deleteProfilePhoto() -> AnyPublisher<Void, Error> {
        // Implement deletion logic here
        // You need to know the storage reference or URL of the user's current profile photo in order to delete it

        // For example, if you have a URL to the current profile photo, you can use it to delete the photo:
        // let storageRef = storage.reference(forURL: imageURL)

        // Delete the photo and handle success or failure
        // storageRef.delete { error in
        //     if let error = error {
        //         promise(.failure(error))
        //     } else {
        //         promise(.success(()))
        //     }
        // }
        
        // Placeholder for the delete logic
        return Empty<Void, Error>().eraseToAnyPublisher()
    }
}

enum ProfilePhotoError: Error {
    case imageConversionError
}
