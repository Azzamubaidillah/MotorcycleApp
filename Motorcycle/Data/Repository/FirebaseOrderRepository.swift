//
//  FirebaseOrderRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Combine

class FirebaseOrderRepository: OrderRepository {
    private let db = Firestore.firestore()

    func createOrder(_ order: Order) -> AnyPublisher<Void, Error> {
        let ordersCollection = db.collection("orders")

        // Convert the Order struct to a dictionary for Firestore
        let orderData: [String: Any] = [
            "orderID": order.orderID,
            "userID": order.userID,
            "motorcycleID": order.motorcycleID,
            "orderDate": order.orderDate,
            "orderStatus": order.orderStatus.rawValue,
            "paymentInfo": [
                "totalAmount": order.paymentInfo.totalAmount,
                "paymentMethod": order.paymentInfo.paymentMethod,
                "transactionID": order.paymentInfo.transactionID
            ],
            "quantity": order.quantity,
            "totalPrice": order.totalPrice
        ]

        // Add the order document to the "orders" collection
        return Future<Void, Error> { promise in
            ordersCollection.document(order.orderID).setData(orderData) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getOrders(forUser userID: String) -> AnyPublisher<[Order], Error> {
        let ordersCollection = db.collection("orders")

        // Query orders for the specified user
        let query = ordersCollection.whereField("userID", isEqualTo: userID)

        // Fetch the documents and decode them into Order objects
        return Future<[Order], Error> { promise in
            query.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let decoder = Firestore.Decoder()
                    let orders = snapshot?.documents.compactMap { document in
                        try? decoder.decode(Order.self, from: document.data())
                    } ?? []

                    promise(.success(orders))
                }
            }
        }.eraseToAnyPublisher()
    }


    // Implement other methods for updating and deleting orders as needed
}
