//
//  DetailView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 10/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import Resolver
import SwiftUI

struct DetailView: View {
    let motorcycle: Motorcycle
    let uid: String
    @State private var isOrdering = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: motorcycle.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    }
                    Spacer()
                }

                Divider()

                Text(motorcycle.name)
                    .font(.largeTitle)
                    .padding()

                Text(motorcycle.description)
                    .font(.body)
                    .padding()

                Text("Price: $\(motorcycle.price)")
                    .font(.headline)
                    .padding()

                Text("Displacement: \(motorcycle.displacement)")
                    .font(.subheadline)
                    .padding()

                Text("Power: \(motorcycle.power)")
                    .font(.subheadline)
                    .padding()

                Text("Torque: \(motorcycle.torque)")
                    .font(.subheadline)
                    .padding()

                Text("Engine: \(motorcycle.engine)")
                    .font(.subheadline)
                    .padding()

                Text("Cooling: \(motorcycle.cooling)")
                    .font(.subheadline)
                    .padding()

                NavigationLink(
                    destination: OrderView(
                        viewModel: Resolver.resolve(OrderViewModel.self), uid: uid, motorcycle: motorcycle)) {
                    HStack {
                        Spacer()
                        Text("Order Bike")
                           
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
        }
    }
}
