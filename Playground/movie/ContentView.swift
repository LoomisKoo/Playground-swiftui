

struct User {
    var username: String
    var password: String
}

struct UserContentView: View {
    @State private var selection = 0
    @State private var isLogin = false
    @State private var username = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    // 存储用户信息的 User 对象
    @AppStorage("user") var userStorage = Data()
    
    // 解码 User 对象
    var user: User? {
        guard let data = try? JSONDecoder().decode(User.self, from: userStorage) else { return nil }
        return data
    }
    
    var body: some View {
        TabView(selection: $selection) {
            // ...
        }
        .onAppear {
            // 自动登录
            if let user = user {
                self.username = user.username
                self.password = user.password
                self.rememberMe = true
                self.isLogin = true
            }
        }
    }
}
