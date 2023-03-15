//
//  TabModel.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/3.
//

import Foundation

struct TabContentModel:Identifiable{
    var id = UUID().uuidString
    var title :String
    var content:String
    var name:String
    var price:String
}

struct TabModel: Identifiable{
    var id = UUID().uuidString
    var title :String
    var contents:[TabContentModel]
}
