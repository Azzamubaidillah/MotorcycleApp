//
//  MotorcycleDetailView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 09/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI

struct MotorcycleDetailView: View {
    let motorcycle: Motorcycle

    var body: some View {
        VStack {
            Image(systemName: "photo") // Placeholder image or load from URL
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)

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

            Spacer()
        }
    }
}
