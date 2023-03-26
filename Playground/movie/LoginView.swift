//
//  LoginView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""

    @EnvironmentObject var userData: UserData

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 20)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                Button(action: {
                    // Simulate login
                    if self.username == "user" && self.password == "password" {
                        self.userData.isLogin = true
//                        self.userData.userStorage
                    } else {
                        self.showAlert = true
                        self.errorMessage = "Invalid username or password"
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }

                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserData())
    }
}
