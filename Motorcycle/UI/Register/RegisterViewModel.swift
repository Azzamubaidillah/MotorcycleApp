//
//  RegisterViewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Resolver
import Combine

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var showAlert = false
    @Published var alertMessage = ""

    // Inject the AuthenticationRepository
    @Injected private var authRepository: AuthenticationRepository

    private var cancellables = Set<AnyCancellable>()

    init() {}

    func register() {
        guard password == confirmPassword else {
            showAlert = true
            alertMessage = "Passwords do not match."
            return
        }

        authRepository.register(email: email, password: password, firstName: firstName, lastName: lastName)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    // Handle registration error
                    self?.showAlert = true
                    self?.alertMessage = error.localizedDescription
                }
            } receiveValue: { _ in
                // Registration successful, perform any necessary actions
            }
            .store(in: &cancellables)
    }
}
