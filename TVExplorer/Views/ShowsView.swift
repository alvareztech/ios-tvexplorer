//
//  ContentView.swift
//  TVExplorer
//
//  Created by Daniel Alvarez on 01/03/23.
//

import SwiftUI

struct ShowsView: View {
    @StateObject private var viewModel = ShowsViewModel(networkService: NetworkService())
    
    var body: some View {
        NavigationView {
            List(viewModel.shows, id: \.show.id) { show in
                NavigationLink {
                    ShowDetailView(viewModel: viewModel, show: show.show, aliases: $viewModel.currentShowAliases)
                } label: {
                    ShowView(viewModel: viewModel, show: show.show)
                }
            }.navigationTitle("TV Explorer")
                .searchable(text: $viewModel.searchText, prompt: "Search")
                .listStyle(.inset)
        }
        .onChange(of: viewModel.searchText) { searchText in
            Task {
                await viewModel.loadShows()
            }
        }
        .task {
            viewModel.searchText = "house"
            await viewModel.loadShows()
        }
    }
}

struct ShowView: View {
    var viewModel: ShowsViewModel
    var show: Show
    
    var body: some View {
        HStack {
            AsyncImage(url: show.bannerURL,
                       content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            }, placeholder: {
                Image(systemName: "popcorn")
            })
            .frame(maxWidth: 80, maxHeight: 120)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            VStack(alignment: .leading) {
                Text(show.name)
                    .font(.title)
                Text(show.status ?? "")
                    .foregroundColor(show.statusColor)
                    .fontWeight(.bold)
            }.padding()
        }
    }
}
