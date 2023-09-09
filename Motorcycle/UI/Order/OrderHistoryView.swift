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
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.orders.isEmpty {
                    Text("No orders yet")
                
                } else {
                    List(viewModel.orders, id: \.orderID) { order in
                        OrderRow(order: order, cancelOrder: {
                            viewModel.cancelOrder(order.orderID)
                        })
                    }
                }
            }
            .navigationTitle("Order History")
        }
    }
}

struct OrderRow : View {
    let order: Order
    let cancelOrder: () -> Void
    
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.orderID)
                    .font(.headline)
                Text(order.orderStatus.rawValue)
                    .font(.subheadline)
                
            }
            
            Button {
                cancelOrder()
            } label: {
                Text("Cancel")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        
        }
    }
}

