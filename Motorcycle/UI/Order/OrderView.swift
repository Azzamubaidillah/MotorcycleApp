//
//  OrderView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel: OrderViewModel
    
    @State private var deliveryAddress = ""
    @State private var orderNotes = ""

    let motorcycle: Motorcycle
    let uid: String

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Delivery Information")) {
                    TextField("Delivery Address", text: $deliveryAddress)
                }

                Section(header: Text("Order Notes")) {
                    TextEditor(text: $orderNotes)
                }

                Button(action: {
                    // Create the order with the entered details
                    let order = Order(
                        orderID: UUID().uuidString,
                        userID: uid,
                        motorcycleID: motorcycle.uid,
                        orderDate: Date(),
                        orderStatus: .pending,
                        paymentInfo: PaymentInfo(totalAmount: Double(motorcycle.price),
                                                 paymentMethod: "Cash",
                                                 transactionID: UUID().uuidString
                        ),
                        quantity: 1,
                        totalPrice: Double(motorcycle.price))

                    // Call the createOrder method from your OrderViewModel
                    viewModel.createOrder(order)

                    // Dismiss the form
                  
                }) {
                    Text("Place Order")
                }
            }
            .navigationBarTitle("Order Motorcycle", displayMode: .inline)
        }
    }
}
