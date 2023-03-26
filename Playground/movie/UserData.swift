//
//  UserData.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import Foundation

class UserData: ObservableObject {
    @Published var isLogin = false
@Published var userStorage = Data()
    
    var user: User? {
        guard let user = try? JSONDecoder().decode(User.self, from: userStorage) else {
            return nil
        }
        
        return user
    }
}

struct User: Codable {
    var username: String
    var password: String
}

