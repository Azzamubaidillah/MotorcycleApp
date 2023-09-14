//
//  OrderView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Resolver
import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel: OrderViewModel

    @State private var quantity = 1
    @State private var orderNotes = ""
    @State private var motorcycleName: String = ""
    @State private var selectedPaymentMethod = "GPay"
    @State private var totalPrice = 0
    @State private var isBottomSheetOpen = false
    @State private var navigateToHome = false

    let paymentMethods = ["GPay", "Gopay", "Spay", "Paypal"]

    let uid: String
    let motorcycle: Motorcycle

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Delivery Information")) {
                    TextField("Delivery Address", text: $motorcycleName)
                        .disabled(true)
                        .onAppear { // Set the motorcycleName when the view appears
                            motorcycleName = motorcycle.name
                        }
                }

                Section(header: Text("Quantity")) {
                    Stepper(value: $quantity, in: 1 ... 10) {
                        Text("\(quantity)")
                    }
                    .onChange(of: quantity) { newValue in
                        // Update the totalPrice whenever quantity changes
                        totalPrice = newValue * motorcycle.price
                    }
                }

                Section(header: Text("Payment Method")) {
                    ForEach(paymentMethods, id: \.self) { method in
                        Button(action: {
                            selectedPaymentMethod = method
                        }) {
                            HStack {
                                Image(method.lowercased())
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text(method)
                                Spacer()
                                if selectedPaymentMethod == method {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }

                Section(header: Text("Order Notes")) {
                    TextEditor(text: $orderNotes)
                }

                Section(header: Text("Total Price")) {
                    TextField("Total Price", value: $totalPrice, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                        .onAppear {
                            totalPrice = quantity * motorcycle.price
                        }
                }

                Button(action: {
                    // Show the bottom sheet
                    isBottomSheetOpen = true
                }) {
                    Text("Place Order")
                }
            }
            .navigationBarTitle("Order Motorcycle", displayMode: .inline)
        }
        .sheet(isPresented: $isBottomSheetOpen) {
            // Bottom Sheet Content
            VStack(alignment: .leading, spacing: 16) {
                Text("Order Details").font(.title)

                Text("Motorcycle Name: \(motorcycleName)")
                Text("Quantity: \(quantity)")
                Text("Payment Method: \(selectedPaymentMethod)")
                Text("Order Notes: \(orderNotes)")
                Text("Total Price: \(totalPrice)")

                Button(action: {
                    // Call your method to place the order here
                    placeOrder()
                    navigateToHome = true
                }) {
                    Text("Confirm Order")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .background(
                NavigationLink(
                    destination: HomeView(viewModel: Resolver.resolve(HomeViewModel.self)),
                    isActive: $navigateToHome,
                    label: { EmptyView() }
                )
            )
            .padding()
        }
    }

    func placeOrder() {
        // Create the order with the entered details
        let order = Order(
            orderID: UUID().uuidString,
            userID: uid,
            motorcycleID: motorcycle.uid,
            motorcycleName: motorcycleName,
            orderDate: Date(),
            orderStatus: .pending,
            paymentInfo: PaymentInfo(
                totalAmount: Double(totalPrice),
                paymentMethod: selectedPaymentMethod,
                transactionID: UUID().uuidString
            ),
            quantity: quantity,
            totalPrice: Double(totalPrice)
        )

        // Call the createOrder method from your OrderViewModel
        viewModel.createOrder(order)
        
        // Close the bottom sheet
        isBottomSheetOpen = false
    }
}
