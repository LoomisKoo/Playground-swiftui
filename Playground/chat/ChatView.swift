import SwiftUI

struct ChatGptView: View {
    @State var messages: [Message] = []
    @State var messageText = ""

    let openAI = OpenAI()

    var body: some View {
        VStack {
            // 聊天记录列表
            List(messages, id: \.id) { message in
                ChatBubble(role: message.role, content: message.content)
            }
            .listStyle(PlainListStyle())

            Divider()

            // 输入框和发送按钮
            HStack {
                TextField("Type your message here", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    // 向 OpenAI 发送消息
    func sendMessage() {
        let message = Message(id: UUID(), role: "User", content: messageText)
        messages.append(message)

        openAI.sendRequest(prompt: messageText) { result in
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    let message = Message(id: UUID(), role: "Chatbot", content: response.choices.first?.message.content ?? "")
                    messages.append(message)
                    messageText = ""
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// 自定义聊天气泡样式
struct ChatBubble: View {
    let role: String
    let content: String

    var body: some View {
        HStack {
            if role == "User" {
                Spacer()
                Text(content)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(ChatBubbleShape(isFromCurrentUser: true))
            } else {
                Text(content)
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundColor(.black)
                    .clipShape(ChatBubbleShape(isFromCurrentUser: false))
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

// 自定义聊天气泡形状
struct ChatBubbleShape: Shape {
    var isFromCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        let radius: CGFloat = 18

        var corners: UIRectCorner = []
        if isFromCurrentUser {
            corners.formUnion(.topLeft)
            corners.formUnion(.bottomLeft)
            corners.formUnion(.bottomRight)
        } else {
            corners.formUnion(.topRight)
            corners.formUnion(.bottomLeft)
            corners.formUnion(.bottomRight)
        }

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        return Path(path.cgPath)
    }
}
