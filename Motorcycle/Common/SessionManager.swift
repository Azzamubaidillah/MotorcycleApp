//
//  SessionManager.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation
import FirebaseAuth

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
        }
    }
}
