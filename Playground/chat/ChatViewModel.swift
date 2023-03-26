//
//  ChatViewModel.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private let openAI: OpenAI

    init(apiKey: String) {
        self.openAI = OpenAI(apiKey: apiKey)
    }

    func sendMessage(_ message: String) {
        let newMessage = Message(role: .user, content: message)
        messages.append(newMessage)
        openAI.sendRequest(prompt: message) { [weak self] (response) in
            guard let self = self else { return }
            let completion = response.choices[0].text.trimmingCharacters(in: .whitespacesAndNewlines)
            let newMessage = Message(role: .assistant, content: completion)
            DispatchQueue.main.async {
                self.messages.append(newMessage)
            }
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let role: Role
    let content: String
}

enum Role {
    case user
    case assistant
}

