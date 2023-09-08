//
//  HomeViewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import Resolver

class HomeViewModel: ObservableObject {
    @Published var user: User?

    // Inject the AuthenticationRepository
    @Injected private var authRepository: AuthenticationRepository
    @Injected private var userRepository: UserRepository

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        userRepository.fetchUser()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    // Handle error if needed
                    print("Error getting current user: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }

    func logout() {
        authRepository.logout()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    // Handle logout error
                    print("Logout error: \(error.localizedDescription)")
                }
            } receiveValue: { _ in
                // Logout successful, perform any necessary actions
            }
            .store(in: &cancellables)
    }
}
