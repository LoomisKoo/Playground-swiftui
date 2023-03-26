//
//  ChatGPTView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI

struct ChatGPTView: View {
    @State private var inputText = ""
    @State private var chatLog: [String] = []
    
    private let openAIEndpoint = "https://api.openai.com/v1/chat/completions"
    private let openAIModel = "gpt-3.5-turbo"
    private let openAITemperature = 0.7
    
    private func sendMessage() {
        let message = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        
        let body = [
            "model": openAIModel,
            "messages": [["role": "user", "content": message]],
            "temperature": openAITemperature
        ]
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else { return }
        var request = URLRequest(url: URL(string: openAIEndpoint)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(openAPIKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let chatResult = try? JSONDecoder().decode(ChatResult.self, from: data)
            else { return }
            
            DispatchQueue.main.async {
                chatLog.append(chatResult.choices.first?.text ?? "")
            }
        }.resume()
        
        inputText = ""
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatLog, id: \.self) { message in
                    Text(message)
                        .padding()
                }
            }
            HStack {
                TextField("Type your message", text: $inputText, onCommit: sendMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
        }
        .frame(minWidth: 400, minHeight: 300)
    }
}

struct ChatResult: Codable {
    struct Choice: Codable {
        let text: String
    }
    let choices: [Choice]
}

struct ChatGPTView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTView()
    }
}

