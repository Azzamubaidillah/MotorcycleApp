//
//  SuccessOrderView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 13/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import SwiftUI
import Resolver

struct SuccessOrderView: View {
    var body: some View {
        VStack {
            Image("success")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.top, 50)
            
            Text("Order Success")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Your order has been received. Please finish your payment in your selected payment method app.")
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // back to home
            NavigationLink(destination: HomeView(viewModel: Resolver.resolve(HomeViewModel.self))) {
                Text("Back to Home")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
    }
}
