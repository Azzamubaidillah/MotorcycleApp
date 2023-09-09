//
//  OrderViiewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import Foundation
import Resolver

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = [] // A property to store fetched orders

    @Injected var orderRepository: OrderRepository

    private var cancellables: Set<AnyCancellable> = []

    init() {
        // Initialize the view model and fetch orders for the current user
        fetchOrders()
    }

    // Method to fetch orders for the current user
    func fetchOrders() {
        // Get the current user's ID (You may get this from your authentication system)
        let currentUserID = "12345" // Replace with actual user ID

        orderRepository.getOrders()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle any completion (e.g., error handling)
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Error fetching orders: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedOrders in
                // Update the orders property with fetched orders
                self.orders = fetchedOrders
            })
            .store(in: &cancellables)
    }

    // Method to create a new order
    func createOrder(_ order: Order) {
        orderRepository.createOrder(order)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle any completion (e.g., error handling)
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Error creating order: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                // Order created successfully, you can perform any necessary actions
            })
            .store(in: &cancellables)
    }
    
    func cancelOrder(_ orderId: String) {
        orderRepository.cancelOrder(orderId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle any completion (e.g., error handling)
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Error canceling order: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                self.fetchOrders()
            })
            .store(in: &cancellables)
    }

}
