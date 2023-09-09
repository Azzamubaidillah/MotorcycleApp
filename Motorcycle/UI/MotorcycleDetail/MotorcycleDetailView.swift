//
//  MotorcycleDetailView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI
import Resolver

struct MotorcycleDetailView: View {
    let motorcycle: Motorcycle
    let uid: String
    @State private var isOrdering = false

    var body: some View {
        VStack {
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
            
            Text(motorcycle.name)
                .font(.largeTitle)
                .padding()
            
            Text("Price: $\(motorcycle.price)")
                .font(.headline)
                .padding()
            
            Text("Power: \(motorcycle.power)")
                .font(.subheadline)
                .padding()
            
            Text("Torque: \(motorcycle.torque)")
                .font(.subheadline)
                .padding()
            
            // Add more motorcycle details as needed
            
            NavigationLink(
                destination: OrderView(
                    viewModel: Resolver.resolve(OrderViewModel.self), motorcycle: motorcycle, uid: uid)) {
                Text("Order Bike")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
    }
}

