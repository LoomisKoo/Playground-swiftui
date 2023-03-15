//
//  TabViewModel.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/3.
//

import Foundation

class TabViewModel: ObservableObject {
    var items: [TabContentModel] = []

    var tabInfos: [TabModel] = []

    @Published var curTabTitle = ""

    init() {
        items.append(TabContentModel(title: "title1", content: "content1", name: "name1", price: "¥9.9"))
        items.append(TabContentModel(title: "title2", content: "content2", name: "name2", price: "¥9.9"))
        items.append(TabContentModel(title: "title3", content: "content3", name: "name3", price: "¥9.9"))
        items.append(TabContentModel(title: "title4", content: "content4", name: "name4", price: "¥9.9"))
        items.append(TabContentModel(title: "title5", content: "content5", name: "name5", price: "¥9.9"))
        items.append(TabContentModel(title: "title6", content: "content6", name: "name6", price: "¥9.9"))
        items.append(TabContentModel(title: "title7", content: "content7", name: "name7", price: "¥9.9"))
        items.append(TabContentModel(title: "title8", content: "content8", name: "name8", price: "¥9.9"))
        items.append(TabContentModel(title: "title9", content: "content9", name: "name9", price: "¥9.9"))

        tabInfos.append(TabModel(title: "Tab1", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab2", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab3", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab4", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab5", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab6", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab7", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab8", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab9", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab10", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab11", contents: items.shuffled()))
        tabInfos.append(TabModel(title: "Tab12", contents: items.shuffled()))

        curTabTitle = tabInfos.first?.title ?? ""
    }
}
