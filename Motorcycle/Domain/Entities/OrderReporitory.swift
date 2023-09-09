//
//  OrderReporitory.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine

protocol OrderRepository {
    func createOrder(_ order: Order) -> AnyPublisher<Void, Error>
    func getOrders() -> AnyPublisher<[Order], Error>
    func cancelOrder(_ orderID: String) -> AnyPublisher<Void, Error>
    // Add more methods for updating and deleting orders as needed
}
