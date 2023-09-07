//
//  LoginViewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Resolver
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published var alertMessage = ""

    // Inject the AuthenticationRepository
    @Injected private var authRepository: AuthenticationRepository

    private var cancellables = Set<AnyCancellable>()

    init() {}

    func login() {
        authRepository.login(email: email, password: password)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    // Handle login error
                    self?.showAlert = true
                    self?.alertMessage = error.localizedDescription
                }
            } receiveValue: { _ in
                // Login successful, perform any necessary actions
            }
            .store(in: &cancellables)
    }
}
