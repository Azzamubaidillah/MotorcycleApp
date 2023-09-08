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
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    // Inject the AuthenticationRepository
    @Injected private var authRepository: AuthenticationRepository
    @Injected private var userRepository: UserRepository

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUserProfile()
    }

    func fetchUserProfile() {
        userRepository.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    // Handle the fetch user error
                    print("Error fetching user: \(error.localizedDescription)")
                }
            }, receiveValue: { user in
                // Update the UI with the fetched user data
                self.firstName = user?.firstName ?? "default"
                self.lastName = user?.lastName ?? "default"
                self.email = user?.email ?? "default"
                // Load the profile photo, you can implement this separately
            })
            .store(in: &cancellables)
    }

}
