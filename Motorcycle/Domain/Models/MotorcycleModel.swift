//
//  MotorcycleModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

struct Motorcycle: Codable, Identifiable {
    let uid: String
    let brand: String
    let name: String
    let description: String
    let price: Int
    let power: String
    let torque: String
    let displacement: String
    let cooling: String
    let engine: String
    let imageUrl: String

    var id: String { uid }

    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case description
        case brand
        case price
        case power
        case torque
        case displacement
        case cooling
        case engine
        case imageUrl
    }
}

