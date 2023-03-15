//
//  CardView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/8.
//

import SwiftUI

// MARK: card view

// whole big item,include titleView and itemsViews
struct CardView: View {
    var tabInfo: TabModel
    @Binding var curTabTitle: String
    @Binding var isDraging: Bool

    var body: some View {
        LazyVStack(alignment: .leading) {
            // title
            titleView
            // items
            itemViews
        }
        .id(tabInfo.title)
        .modifier(OffsetModifier(tabInfo: tabInfo, curTabTitle: $curTabTitle, isDraging: $isDraging))
    }
}

// MARK: TitleView

extension CardView {
    var titleView: some View {
        Text(tabInfo.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.black.opacity(0.7))
            .padding()
    }
   
}

// MARK: - itemViews

extension CardView {
    var itemViews: some View {
        ForEach(tabInfo.contents) { item in
            LazyVStack(alignment: .leading) {
                HStack {
                    // title
                    Text(item.title)
                        .font(.title)
                    Spacer()
                    // price
                    Text(item.price)
                        .font(.title3)
                }
                // content
                Text(item.content)
                    .font(.title3)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).opacity(0.1)
            )
        }
    }
}
