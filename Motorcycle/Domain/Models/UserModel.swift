//
//  UserModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var uid: String?
    let email: String
    let firstName: String
    let lastName: String
    let profilePhotoURL: String?

    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case firstName
        case lastName
        case profilePhotoURL
    }
}
