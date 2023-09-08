//
//  FirebaseUserRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class FirebaseUserRepository: UserRepository {
    private let db = Firestore.firestore()

    // MARK: - Fetch User

    func fetchUser() -> AnyPublisher<User, Error> {
        guard let userId = Auth.auth().currentUser?.uid else {
            // Return an error if there's no authenticated user
            return Fail<User, Error>(error: FirebaseUserRepositoryError.userNotAuthenticated)
                .eraseToAnyPublisher()
        }

        return Future<User, Error> { promise in
            let userRef = self.db.collection("users").document(userId)

            userRef.getDocument { (document, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let document = document, document.exists {
                    do {
                        // Create a Firestore.Decoder instance
                        let firestoreDecoder = Firestore.Decoder()

                        // Decode the user data from Firestore document using the Firestore.Decoder
                        let user = try firestoreDecoder.decode(User.self, from: document.data() ?? [:])

                        promise(.success(user))
                    } catch {
                        promise(.failure(error))
                    }
                } else {
                    // No user document found
                    promise(.failure(FirebaseUserRepositoryError.userNotFound))
                }
            }
        }
        .eraseToAnyPublisher()
    }


    // MARK: - Update User

    func updateUser(firstName: String, lastName: String) -> AnyPublisher<Void, Error> {
        guard let userId = Auth.auth().currentUser?.uid else {
            // Return an error if there's no authenticated user
            return Fail<Void, Error>(error: FirebaseUserRepositoryError.userNotAuthenticated)
                .eraseToAnyPublisher()
        }

        return Future<Void, Error> { promise in
            let userRef = self.db.collection("users").document(userId)

            // Create a dictionary with updated user data
            let userData: [String: Any] = [
                "firstName": firstName,
                "lastName": lastName
            ]

            // Update the user data in Firestore
            userRef.updateData(userData) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // - MARK: Logout
    
    func logout() -> AnyPublisher<Void, Error> {
        return Future { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

