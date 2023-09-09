//
//  ProfileViewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Combine
import Foundation
import Resolver

class ProfileViewModel: ObservableObject {
    @Published var uid: String = ""
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var profilePhotoURL: String = ""
    @Published var profilePhoto: UIImage?
    
    @Injected var userRepository: UserRepository
    @Injected var profilePhotoRepository: ProfilePhotoRepository
    
    private var cancellables: Set<AnyCancellable> = []

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
                self.uid = user?.uid ?? "default"
                self.firstName = user?.firstName ?? "default"
                self.lastName = user?.lastName ?? "default"
                self.email = user?.email ?? "default"
                self.profilePhotoURL = user?.profilePhotoURL ?? "default"
                
                // Load the profile photo, you can implement this separately
            })
            .store(in: &cancellables)
    }

    func updateProfile() {
        userRepository.updateUser(firstName: firstName, lastName: lastName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    // Handle the update user error
                    print("Error updating user: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                // User data updated successfully
                // Now, update the profile photo if it has changed
                if let newProfilePhoto = self.profilePhoto {
                    self.updateProfilePhoto(newProfilePhoto)
                }
            })
            .store(in: &cancellables)
    }

    private func updateProfilePhoto(_ newProfilePhoto: UIImage) {
        profilePhotoRepository.uploadProfilePhoto(newProfilePhoto)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    // Handle the upload profile photo error
                    print("Error uploading profile photo: \(error.localizedDescription)")
                }
            }, receiveValue: { imageURL in
                // Profile photo uploaded successfully
                // Now, update the user's profile photo URL in Firestore
                self.profilePhotoRepository.updateProfilePhotoURL(imageURL)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case let .failure(error):
                            // Handle the update profile photo URL error
                            print("Error updating profile photo URL: \(error.localizedDescription)")
                        }
                    }, receiveValue: { _ in
                        // Profile photo URL updated successfully
                        // You can perform any additional actions here if needed
                    })
                    .store(in: &self.cancellables)
            })
            .store(in: &cancellables)
    }

    func logout() {
        userRepository.logout()
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
