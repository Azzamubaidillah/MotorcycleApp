//
//  AuthenticationRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation
import Combine

protocol AuthenticationRepository {
    func register(email: String, password: String, firstName: String, lastName: String) -> AnyPublisher<User, Error>
    func login(email: String, password: String) -> AnyPublisher<User, Error>
    func logout() -> AnyPublisher<Void, Error>
    
}
