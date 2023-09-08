//
//  FirebaseAuthenticationRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

class FirebaseAuthenticationRepository: AuthenticationRepository {
    func register(email: String, password: String, firstName: String, lastName: String) -> AnyPublisher<User, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = authResult?.user {
                    // User registration successful
                    let newUser = User(uid: user.uid, email: email, firstName: firstName, lastName: lastName, profilePhotoURL: "")
                    self.createUserDocument(uid: newUser.uid!, email: newUser.email, firstName: newUser.firstName, lastName: newUser.lastName)
                    promise(.success(newUser))
                } else {
                    promise(.failure(AuthenticationError.unknown))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = authResult?.user {
                    // User login successful
                    let userEmail = user.email ?? ""
                    let newUser = User(uid: user.uid, email: userEmail, firstName: "", lastName: "", profilePhotoURL: "")
                    promise(.success(newUser))
                } else {
                    promise(.failure(AuthenticationError.unknown))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func createUserDocument(uid: String, email: String, firstName: String, lastName: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        userRef.setData([
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "profilePhotoURL": ""
        ]) { error in
            if let error = error {
                // Handle the Firestore data creation error
                print("Error creating user document: \(error.localizedDescription)")
            } else {
                // User data is successfully stored in Firestore
                print("User document created successfully.")
            }
        }
    }
}
