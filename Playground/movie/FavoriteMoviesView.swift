//
//  FavoriteMoviesView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI

struct FavoriteMoviesView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(MockData.favoriteMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieListItemView(movie: movie)
                    }
                }
            }
            .navigationTitle("收藏")
        }
    }
}

