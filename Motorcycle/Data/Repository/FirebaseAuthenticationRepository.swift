//
//  FirebaseAuthenticationRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import FirebaseAuth

class FirebaseAuthenticationRepository: AuthenticationRepository {
    func register(email: String, password: String, firstName: String, lastName: String) -> AnyPublisher<User, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = authResult?.user {
                    // User registration successful
                    let newUser = User(uid: user.uid, email: email, firstName: firstName, lastName: lastName)
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
                    let newUser = User(uid: user.uid, email: userEmail, firstName: "", lastName: "")
                    promise(.success(newUser))
                } else {
                    promise(.failure(AuthenticationError.unknown))
                }
            }
        }
        .eraseToAnyPublisher()
    }

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

    func getCurrentUser() -> AnyPublisher<User?, Error> {
        return Future { promise in
            if let currentUser = Auth.auth().currentUser {
                // You can create a User object with the user's data
                let user = User(
                    uid: currentUser.uid,
                    email: currentUser.email ?? "",
                    firstName: "",
                    lastName: ""
                )
                promise(.success(user))
            } else {
                // No user is currently authenticated
                promise(.success(nil))
            }
        }
        .eraseToAnyPublisher()
    }
}
