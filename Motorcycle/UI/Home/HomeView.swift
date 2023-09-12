//
//  HomeView.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 08/09/23.
//  Copyright © 2023 Azzam Ubaidillah. All rights reserved.
//

import ModalView
import Resolver
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    CatalogueView(viewModel: viewModel)
                        .tabItem {
                            Label("Catalogue", systemImage: "list.bullet")
                        }

                    GalleryView(viewModel: viewModel
                    )
                    .tabItem {
                        Label("Gallery", systemImage: "photo")
                    }
                }
            }
            .navigationTitle(viewModel.greetingMessage)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: ProfileView(viewModel: Resolver.resolve(ProfileViewModel.self))
                    ) {
                        AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .font(.title)
                        }
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

struct CatalogueView: View {
    @ObservedObject var viewModel: HomeViewModel

    let brands = ["ducati", "yamaha", "honda", "bmw", "aprilia"]
    @State private var selectedBrand: String? = nil

    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16),
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16),
    ]

    var filteredMotorcycles: [Motorcycle] {
        if let selectedBrand = selectedBrand {
            return viewModel.motorcycles.filter { $0.brand == selectedBrand.capitalized }
        } else {
            return viewModel.motorcycles
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Popular Brand")
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)

                HStack {
                    Spacer()
                    ForEach(brands, id: \.self) { brand in
                        Button(action: {
                            if selectedBrand == brand {
                                selectedBrand = nil
                            } else {
                                selectedBrand = brand
                            }
                        }) {
                            Rectangle()
                                .fill(selectedBrand == brand ? Color.gray : Color.white)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(brand)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(8)
                                )
                                .cornerRadius(8)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 4)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredMotorcycles, id: \.uid) { motorcycle in
                        NavigationLink(destination: DetailView(motorcycle: motorcycle, uid: viewModel.uid)) {
                            CatalogueCard(motorcycle: motorcycle)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
    }
}

struct GalleryView: View {
    let viewModel: HomeViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.motorcycles, id: \.uid) { image in
                    ModalPresenter {
                        ModalLink(destination: AsyncImage(url:  URL(string: image.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)                        }
                        .cornerRadius(8)
                        .background(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        ) {
                            VStack {
                                AsyncImage(url: URL(string: image.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 200)
                                } placeholder: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 200)
                                }
                                .cornerRadius(8)
                                .background(.white)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 4)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                                Text(image.name)
                                    .font(.headline)
                                    .padding(.top, 10)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    
                    }
                }
            }
            .padding()
        }
    }
}

struct CatalogueCard: View {
    let motorcycle: Motorcycle

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: motorcycle.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
            }

            VStack(alignment: .leading) {
                Text(motorcycle.name)
                    .font(.headline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text("$\(motorcycle.price)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding(.top, 5)

                    Spacer()

                    Text(motorcycle.displacement)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }

                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 4)
    }
}
