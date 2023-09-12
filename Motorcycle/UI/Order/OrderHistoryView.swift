//
//  OrderHistoryView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 10/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI

struct OrderHistoryView: View {
    @ObservedObject var viewModel: OrderViewModel
    @State private var showAlert = false
    @State private var orderToCancel: Order? // Store the order to cancel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.orders.isEmpty {
                    Text("No orders yet")
                } else {
                    List(viewModel.orders, id: \.orderID) { order in
                        OrderRow(order: order, cancelOrder: {
                            // Set the order to cancel
                            orderToCancel = order
                            showAlert = true // Show the alert
                        })
                    }
                }
            }
            .navigationTitle("Order History")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Cancel Order"),
                    message: Text("Are you sure you want to cancel this order?"),
                    primaryButton: .destructive(Text("Yes"), action: {
                        if let order = orderToCancel {
                            // Handle order cancellation here
                            viewModel.cancelOrder(order.orderID)
                            // Refresh the view by updating the view model
                            viewModel.fetchOrders()
                        }
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct OrderRow: View {
    let order: Order
    let cancelOrder: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.motorcycleName)
                    .font(.headline)
                Text(order.orderStatus.rawValue)
                    .font(.subheadline)
            }

            Spacer()

           if order.orderStatus == .pending {
                Button(action: cancelOrder) {
                    Text("Cancel")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}
