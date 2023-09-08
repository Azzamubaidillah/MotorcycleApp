//
//  EditProfileView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
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
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }

                Button(action: {
                    isEditingPhoto = true
                }) {
                    Text("Change Photo")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isEditingPhoto) {
                    ImagePicker(selectedImage: $viewModel.profilePhoto)
                }

                TextField("First Name", text: $viewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Last Name", text: $viewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Save Changes") {
                    viewModel.updateProfile()
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Profile")
        }
    }
}
