//
//  FirebaseMotorcycleRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import FirebaseFirestore
import Combine

class FirebaseMotorcycleRepository: MotorcycleRepository {
    private let db = Firestore.firestore()

    func fetchMotorcycles() -> AnyPublisher<[Motorcycle], Error> {
        return Future<[Motorcycle], Error> { promise in
            let motorcyclesRef = self.db.collection("motorcycles")

            motorcyclesRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    var motorcycles: [Motorcycle] = []
                    
                    for document in querySnapshot?.documents ?? [] {
                        do {
                            
                            let motorcycle = try document.data(as: Motorcycle.self)
                            motorcycles.append(motorcycle)
                           
                        } catch {
                            promise(.failure(error))
                            return
                        }
                    }

                    promise(.success(motorcycles))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
