//
//  SummaryView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 13/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryViewModel

    var body: some View {
        NavigationView {
            VStack {
                OrderBarChart(orders: viewModel.orders) // Add the chart here
                    .frame(height: 200) // Adjust the size as needed
            }
            .navigationBarTitle("Summary Dashboard")
        }
        .onAppear {
            viewModel.fetchOrders()
        }
    }
}

struct OrderBarChart: View {
    var orders: [Order]

    var body: some View {
        VStack {
            Text("Order Quantities")
                .font(.headline)
                .padding(.bottom, 10)

            // Bar chart
            VStack(spacing: 10) {
                ForEach(orders, id: \.orderID) { order in
                    HStack {
                        Text(order.motorcycleName)
                            .frame(width: 80, alignment: .leading)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: CGFloat(order.quantity), height: 20)
                        Text("\(order.quantity)")
                    }
                }
            }
        }
        .padding()
    }
}

