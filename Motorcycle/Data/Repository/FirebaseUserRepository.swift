//
//  FirebaseUserRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Resolver
import Combine
import FirebaseAuth

class FirebaseUserRepository: UserRepository {
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

    // Implement other user-related methods as needed
}
