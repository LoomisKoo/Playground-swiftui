//
//  ContentView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/3.
//

import SwiftUI

// MARK: - include tabLayout and vertical scrollView
struct TabAndList: View {
    @StateObject var vm = TabViewModel()
    @State var isDraging = false

    var body: some View {
            VStack {
                tabLayout
                contentScrollView
            }
            .padding()
        .ignoresSafeArea(edges: .bottom)
        .background(.blue)
    }
}

// MARK: - TabLayout
extension TabAndList {
    var tabLayout: some View {
        ScrollViewReader { proxin in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom) {
                    ForEach(vm.tabInfos) { tab in
                        VStack(spacing: 0) {
                            
                            // MARK: tabItem
                            Text(tab.title)
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(0)
                                .padding(.horizontal, 5)
                                .opacity(vm.curTabTitle == tab.title ? 1 : 0.5)

                            let _ = print("title:\(vm.curTabTitle)")
 
                            Indicator(curTabTitle: $vm.curTabTitle,title: tab.title)
                        }
                        .id(tab.title)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isDraging = false
                                vm.curTabTitle = tab.title
                                proxin.scrollTo(vm.curTabTitle, anchor: .center)
                            }
                        }
                    }
                }
            }
            .onChange(of: vm.curTabTitle) { _ in
                if isDraging {
                    withAnimation {
                        proxin.scrollTo(vm.curTabTitle, anchor: .center)
                    }
                }
            }
        }
    }
}

// MARK: - tab's indicator

struct Indicator :View{
    @Binding var curTabTitle :String
    var title:String = ""
    
    @Namespace var indicatorAnimation
    
    var body: some View{
        if curTabTitle == title {
            Capsule()
                .fill(.black.opacity(0.6))
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
}

// MARK: - ContentScrollView （vertical）

extension TabAndList {
    var contentScrollView: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyVStack(alignment: .leading) {
                    ForEach(vm.tabInfos) { tab in
                        CardView(tabInfo: tab, curTabTitle: $vm.curTabTitle, isDraging: $isDraging)
                    }
                }
                .onChange(of: vm.curTabTitle) { _ in
                    if !isDraging {
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(vm.curTabTitle, anchor: .topLeading)
                        }
                    }
                }
            }
        }
        .gesture(DragGesture().onChanged({ _ in
            isDraging = true
        }))
        .coordinateSpace(name: "SCROLL")
    }
}


struct TabAndList_Previews: PreviewProvider {
    static var previews: some View {
        TabAndList()
    }
}


