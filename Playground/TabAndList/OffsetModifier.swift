//
//  OffsetModifier.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/8.
//

import SwiftUI


// MARK: Scroll offset modifier

struct OffsetModifier: ViewModifier {
    var tabInfo: TabModel
    @Binding var curTabTitle: String
    @Binding var isDraging: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { proxy in
                let offset = proxy.minY

                if isDraging {
                    if tabInfo.title == "Tab1" {
                        print("\(proxy.maxY)  \(proxy.height)  \(proxy.minY)")
                    }
                    // 是否整个item占满了屏幕
                    let isItemFullScreen: Bool = proxy.maxY > 0 && proxy.maxY <= proxy.height - 200 && proxy.minY <= 0
                    if offset <= 0 && -offset < (proxy.midX / 2) && curTabTitle != tabInfo.title || isItemFullScreen {
                        withAnimation(.easeInOut) {
                            curTabTitle = tabInfo.title
                        }
                    }
                }
            }
    }
}
