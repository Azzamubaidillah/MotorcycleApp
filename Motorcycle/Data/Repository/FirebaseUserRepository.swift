//
//  FirebaseUserRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

class FirebaseUserRepository: UserRepository {
    func getCurrentUser() -> AnyPublisher<User?, Error> {
        guard let currentUser = Auth.auth().currentUser else {
            // No user is currently authenticated
            return Just(nil)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        // Create a Firestore reference to the user's document
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUser.uid)

        // Fetch the user's document from Firestore
        return Future { promise in
            userRef.getDocument { document, error in
                if let error = error {
                    // Handle the Firestore fetch error
                    promise(.failure(error))
                } else if let document = document, document.exists {
                    // Parse and use the user data here
                    let userData = document.data()
                    let email = currentUser.email ?? ""
                    let firstName = userData?["firstName"] as? String ?? ""
                    let lastName = userData?["lastName"] as? String ?? ""

                    let user = User(uid: currentUser.uid, email: email, firstName: firstName, lastName: lastName)

                    promise(.success(user))
                } else {
                    // Handle the case where the document doesn't exist
                    promise(.success(nil))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    // Implement other user-related methods as needed
}
