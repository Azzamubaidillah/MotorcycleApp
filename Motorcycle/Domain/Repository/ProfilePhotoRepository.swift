//
//  ProfilePhotoRepository.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

// ProfilePhotoRepository.swift
import Foundation
import SwiftUI
import Combine

protocol ProfilePhotoRepository {
    func uploadProfilePhoto(_ image: UIImage) -> AnyPublisher<URL, Error>
    func deleteProfilePhoto() -> AnyPublisher<Void, Error>
}
