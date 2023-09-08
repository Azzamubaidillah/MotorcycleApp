//
//  AuthenticationError.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

enum AuthenticationError: Error {
    case registrationFailed
    case loginFailed
    case logoutFailed
    case unknown
}
