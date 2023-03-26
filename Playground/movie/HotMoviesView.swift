//
//  HotMoviesView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI

struct HotMoviesView: View {
    var body: some View {
        List(MockData.hotMovies) { movie in
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                MovieListItemView(movie: movie)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color(red: 0.2, green: 0, blue: 0.4))
                    .foregroundColor(.purple)
                    .cornerRadius(8)
                    .shadow(color: Color.purple.opacity(0.3), radius: 5, x: 0, y: 5)
            }
        }
        .navigationTitle("热映中")
    }
}
