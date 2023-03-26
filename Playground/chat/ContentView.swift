//
//  ContentView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var messages: [Message] = []
    @State private var newMessage: String = ""

    var body: some View {
        NavigationView {
            ChatView(messages: $messages, newMessage: $newMessage) {
                if !newMessage.isEmpty {
                    messages.append(Message(text: newMessage, isSentByUser: true))
                    newMessage = ""
                }
            }
        }
    }
}

