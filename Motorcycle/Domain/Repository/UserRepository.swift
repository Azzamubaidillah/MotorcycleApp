//
//  UserRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine

protocol UserRepository {
    func getCurrentUser() -> AnyPublisher<User?, Error>
    // Add other user-related methods here
}
