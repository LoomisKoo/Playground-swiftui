//
//  TabBarView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//
import SwiftUI

struct MovieView: View {
    @State private var selection = 0
    @ObservedObject var userData: UserData
    
    var body: some View {
        TabView(selection: $selection) {
            HotMoviesView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("热映中")
                }
                .tag(0)
            
            if userData.isLogin {
                FavoriteMoviesView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("收藏")
                    }
                    .tag(1)
            } else {
                LoginView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("收藏")
                    }
                    .tag(1)
            }
            
            if userData.isLogin {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("个人中心")
                    }
                    .tag(2)
            } else {
                LoginView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("个人中心")
                    }
                    .tag(2)
            }
        }
        .accentColor(.pink)
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(userData: UserData())
    }
}
