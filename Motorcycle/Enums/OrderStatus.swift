//
//  OrderStatus.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

enum OrderStatus: String, Codable {
    case pending
    case confirmed
    case shipped
    case delivered
    case canceled
}
