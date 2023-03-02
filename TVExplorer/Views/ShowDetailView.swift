//
//  ShowDetailView.swift
//  TVExplorer
//
//  Created by Daniel Alvarez on 01/03/23.
//

import SwiftUI

struct ShowDetailView: View {
    var viewModel: ShowsViewModel
    var show: Show
    @Binding var aliases: String
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: show.bannerURL,
                           content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                }, placeholder: {
                    Image(systemName: "popcorn")
                })
                .frame(maxWidth: 120, maxHeight: 180)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                VStack {
                    Text(show.name)
                        .font(.largeTitle)
                    Text(show.ratingValue)
                        .font(.body)
                }.padding()
            }
            Text(show.summary?.markdown.toAttributed ?? "")
                .font(.body)
            if !viewModel.currentShowAliases.isEmpty {
                Text("Aliases")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top)
                Text(viewModel.currentShowAliases)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await viewModel.loadAlias(showId: show.id)
        }
    }
}
