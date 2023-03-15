//
//  ContentView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/3.
//

import SwiftUI

struct TabPinnedListView: View {
    @StateObject var vm = TabViewModel()
    @State var isDraging = false
    @State var scrollOffset = CGFloat(0)

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                headerView
                tabAndListView
            }
            .padding(0)
            .frame(maxHeight: .infinity)
        }

        .gesture(DragGesture().onChanged({ _ in
            isDraging = true
        }))
        .coordinateSpace(name: "SCROLL")
        .padding(0)
        .frame(maxHeight: .infinity)
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 33)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(scrollOffset > 0 ? 1 : 0)
        })
        .ignoresSafeArea()
        .background(.blue)
    }
}

private extension TabPinnedListView{
    // MARK: headnerView

    var headerView: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = size.height + minY
            Text("HEADER")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .frame(height: height > 0 ? height : 0)
                .background(.yellow)
                .offset(y: minY > 0 ? -minY : -minY / 1.2)
        }
        .frame(height: 250)
        .background(.black)
    }

    // MARL tabAndListView
    var tabAndListView: some View {
        LazyVStack(pinnedViews: [.sectionHeaders]) {
            Section {
                ContentScrollView2(curTabTitle: $vm.curTabTitle, isDraging: $isDraging, tabInfos: vm.tabInfos)
            } header: {
                TabLayout2(curTabTitle: $vm.curTabTitle, isDraging: $isDraging, tabInfos: vm.tabInfos)
                    .offset(y: scrollOffset > 0 ? scrollOffset : -scrollOffset / 1)
                    .modifier(OffsetModifier3(scrollOffset: $scrollOffset))
            }
        }
    }
}

// MARK: TabLayout

struct TabLayout2: View {
    @Binding var curTabTitle: String
    @Binding var isDraging: Bool
    var tabInfos: [TabModel]

    @Namespace var indicatorAnimation

    var body: some View {
        ScrollViewReader { proxin in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom) {
                    ForEach(tabInfos) { tab in
                        VStack(spacing: 0) {
                            Text(tab.title)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(0)
                                .padding(.horizontal, 5)
                                .opacity(curTabTitle == tab.title ? 1 : 0.5)

                            if curTabTitle == tab.title {
                                Capsule()
                                    .fill(.white.opacity(0.6))
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "TAB", in: indicatorAnimation)
                                    .padding(0)
                                    .padding(.horizontal)
                            } else {
                                Capsule()
                                    .fill(.clear)
                                    .frame(height: 3)
                                    .padding(0)
                                    .padding(.horizontal)
                            }
                        }
                        .id(tab.title)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isDraging = false
                                curTabTitle = tab.title
                                proxin.scrollTo(curTabTitle, anchor: .center)
                            }
                        }
                    }
                }
            }
            .padding(10)
            .background(.black)
            .onChange(of: curTabTitle) { _ in
                if isDraging {
                    withAnimation {
                        proxin.scrollTo(curTabTitle, anchor: .center)
                    }
                }
            }
        }
    }
}

// MARK: ContentScrollView

struct ContentScrollView2: View {
    @Binding var curTabTitle: String
    @Binding var isDraging: Bool
    var tabInfos: [TabModel]

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(tabInfos) { tab in
                CardView2(tabInfo: tab, curTabTitle: $curTabTitle, isDraging: $isDraging)
            }
        }
    }
}

// MARK: card view

struct CardView2: View {
    var tabInfo: TabModel
    @Binding var curTabTitle: String
    @Binding var isDraging: Bool

    var body: some View {
        LazyVStack(alignment: .leading) {
            // title
            Text(tabInfo.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.7))
                .padding()

            // item
            ForEach(tabInfo.contents) { item in
                LazyVStack(alignment: .leading) {
                    HStack {
                        Text(item.title)
                            .font(.title)
                        Spacer()
                        Text(item.price)
                            .font(.title3)
                    }
                    Text(item.content)
                        .font(.title3)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10).opacity(0.1)
                )
            }
        }
        .id(tabInfo.title)
        .modifier(OffsetModifier2(tabInfo: tabInfo, curTabTitle: $curTabTitle, isDraging: $isDraging))
    }
}

// MARK: modifier

struct OffsetModifier2: ViewModifier {
    var tabInfo: TabModel
    @Binding var curTabTitle: String
    @Binding var isDraging: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey2.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey2.self) { proxy in
                let offset = proxy.minY

                if isDraging {
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

struct OffsetModifier3: ViewModifier {
    @Binding var scrollOffset: CGFloat
    @State var startValue: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey2.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey2.self) { proxy in
                scrollOffset = proxy.minY
                // 33约等于状态栏高度
                if proxy.minY < 33 {
                    scrollOffset = 33 - proxy.minY
                } else {
                    scrollOffset = 0
                }
            }
    }
}

struct OffsetKey2: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct TabPinnedListView_Previews: PreviewProvider {
    static var previews: some View {
        TabPinnedListView()
    }
}
