//
//  ProfileView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 30)

                Text("用户名：John Doe")
                    .padding(.top, 20)

                Spacer()
            }
            .navigationTitle("个人中心")
        }
    }
}

