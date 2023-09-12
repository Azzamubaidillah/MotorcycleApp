//
//  SummaryViewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 13/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import Foundation
import Resolver

class SummaryViewModel: ObservableObject {
    @Published var orders: [Order] = [] // A property to store fetched orders

    @Injected var orderRepository: OrderRepository

    private var cancellables: Set<AnyCancellable> = []

    init() {
        // Initialize the view model and fetch orders for the current user
        fetchOrders()
    }

    // Method to fetch orders for the current user
    func fetchOrders() {
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
}
