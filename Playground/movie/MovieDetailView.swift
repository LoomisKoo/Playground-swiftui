//
//  MovieDetailView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(systemName: movie.poster)
                    .resizable()
                    .frame(height: 300)
                    .clipped()
                 

                HStack {
                    Text(movie.title)
                        .font(.title)

                    Spacer()

                    Text(movie.releaseDate)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Text(movie.description)
                    .padding()

                HStack {
                    Text("评分：")
                        .font(.headline)

                    Text(movie.rating)
                        .font(.headline)

                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle(movie.title)
            .padding()
        }
    }
}
