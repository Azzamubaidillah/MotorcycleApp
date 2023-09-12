//
//  OrderModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation

struct Order: Codable {
    let orderID: String
    let userID: String
    let motorcycleID: String
    let motorcycleName: String
    let orderDate: Date
    let orderStatus: OrderStatus
    let paymentInfo: PaymentInfo
    let quantity: Int
    let totalPrice: Double
}

struct PaymentInfo: Codable {
    let totalAmount: Double
    let paymentMethod: String
    let transactionID: String
}
