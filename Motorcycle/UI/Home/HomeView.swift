//
//  HomeView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI
import Resolver

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Home View!")
                    .font(.title)

                NavigationLink(destination: ProfileView(viewModel: Resolver.resolve(ProfileViewModel.self))) {
                    Text("Go to Profile")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Home")
        }
        .onAppear() {
            print(viewModel.firstName ?? "any")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: Resolver.resolve(ProfileViewModel.self))
    }
}
