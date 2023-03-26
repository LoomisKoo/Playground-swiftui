//
//  MovieListItemView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//
import SwiftUI

struct MovieListItemView: View {
    var movie: Movie
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: movie.poster)
                    .resizable()
                    .frame(width: 80, height: 120)
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(movie.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(red: 0.22, green: 0.11, blue: 0.44))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}
