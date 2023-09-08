//
//  FirebaseMotorcycleRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseMotorcycleRepository: MotorcycleRepository {
    private let db = Firestore.firestore()

    func fetchMotorcycles() -> AnyPublisher<[Motorcycle], Error> {
        return Future<[Motorcycle], Error> { promise in
            let motorcyclesCollection = self.db.collection("motorcycles")
            motorcyclesCollection.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let decoder = Firestore.Decoder()
                    let motorcycles = try snapshot?.documents.compactMap { decoder.decode(Motorcycle.self, from: $0.data()) }
                    promise(.success(motorcycles ?? []))
                }
            }
        }.eraseToAnyPublisher()
    }
}
