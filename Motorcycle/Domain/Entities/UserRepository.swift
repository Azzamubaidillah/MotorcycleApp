//
//  UserRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation
import Combine

protocol UserRepository {
    func fetchUser() -> AnyPublisher<User?, Error>
    func updateUser(firstName: String, lastName: String) -> AnyPublisher<Void, Error>
    func logout() -> AnyPublisher<Void, Error>
}
