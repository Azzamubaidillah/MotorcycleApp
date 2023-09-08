//
//  FetchMotorcyclesUseCase.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import Resolver

protocol FetchMotorcyclesUseCase {
    func execute() -> AnyPublisher<[Motorcycle], Error>
}

class DefaultFetchMotorcyclesUseCase: FetchMotorcyclesUseCase {
    @Injected private var repository: MotorcycleRepository

    func execute() -> AnyPublisher<[Motorcycle], Error> {
        return repository.fetchMotorcycles()
    }
}
