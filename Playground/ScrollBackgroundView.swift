//
//  ScrollBackgroundView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/19.
//

import SwiftUI

struct ScrollBackroundView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("header")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)
                .background(.red)

            ZStack {
                VStack {
                    Text("Top hidden text")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black.opacity(0.3))
                        .padding()

                    Spacer()

                    Text("Bottom hidden text")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black.opacity(0.3))
                }

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0 ..< 10) { index in
                            itemView("text No \(index)")

                            Divider()
                                .frame(height: 1)
                                .background(.white)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    fileprivate func itemView(_ text: String) -> some View {
        Text(text)
            .font(.title)
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(.blue)
    }
}

struct ScrollBackroundView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollBackroundView()
    }
}
