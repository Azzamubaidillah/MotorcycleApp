//
//  ProfileView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var isEditingPhoto = false

    var body: some View {
        NavigationView {
            VStack {
                if let profilePhoto = viewModel.profilePhoto {
                    Image(uiImage: profilePhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    // Use the profilePhotoURL directly (no need for optional binding)
                    AsyncImage(url: URL(string: viewModel.profilePhotoURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }

                Text("Email: \(viewModel.email)")
                    .font(.headline)
                    .padding()

                Text("First Name: \(viewModel.firstName)")
                    .font(.headline)
                    .padding()

                Text("Last Name: \(viewModel.lastName)")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: EditProfileView(viewModel: viewModel)) {
                    Text("Edit Profile")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Button("Logout") {
                    viewModel.logout()
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel()
        return ProfileView(viewModel: viewModel)
    }
}
