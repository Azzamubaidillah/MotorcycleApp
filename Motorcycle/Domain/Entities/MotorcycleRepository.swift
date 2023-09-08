//
//  MotorcycleRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine

protocol MotorcycleRepository {
    func fetchMotorcycles() -> AnyPublisher<[Motorcycle], Error>
}
