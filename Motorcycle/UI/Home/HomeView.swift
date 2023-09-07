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
                if let user = viewModel.user {
                    Text("Welcome, \(user.firstName) \(user.lastName)")
                        .font(.title)
                        .padding()

                } else {
                    ProgressView("Loading...")
                }

                Button("Logout") {
                    viewModel.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Initialize your HomeViewModel here if needed
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
