//
//  ProfileViewModel.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ProfileViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var profilePhoto: UIImage?

    @Injected var userRepository: UserRepository
    @Injected var profilePhotoRepository: ProfilePhotoRepository

    private var cancellables: Set<AnyCancellable> = []

    func fetchUserProfile() {
            userRepository.fetchUser()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        // Handle the fetch user error
                        print("Error fetching user: \(error.localizedDescription)")
                    }
                }, receiveValue: { user in
                    // Update the UI with the fetched user data
                    self.firstName = user.firstName
                    self.lastName = user.lastName
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
                    case .failure(let error):
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
                    case .failure(let error):
                        // Handle the upload profile photo error
                        print("Error uploading profile photo: \(error.localizedDescription)")
                    }
                }, receiveValue: { imageURL in
                    // Profile photo uploaded successfully, you can update the user's profile photo URL in Firestore here
                })
                .store(in: &cancellables)
        }
    }
