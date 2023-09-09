//
//  HomeView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Resolver
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.greetingMessage)
                    .font(.headline)
                    .padding()

                List(viewModel.motorcycles, id: \.uid) { motorcycle in
                    NavigationLink(destination: MotorcycleDetailView(motorcycle: motorcycle, uid: viewModel.uid)) {
                        MotorcycleThumbnailView(motorcycle: motorcycle)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(viewModel: Resolver.resolve(ProfileViewModel.self))) {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: Resolver.resolve(ProfileViewModel.self))
    }
}

struct MotorcycleThumbnailView: View {
    let motorcycle: Motorcycle

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: motorcycle.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }

            Text(motorcycle.name)
                .font(.headline)

            Text("$\(motorcycle.price)")
                .font(.subheadline)
        }
        .padding()
    }
}
