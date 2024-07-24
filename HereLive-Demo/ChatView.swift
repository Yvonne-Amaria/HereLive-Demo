//
//  ChatView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct ChatView: View {
    let chats = [
        ChatProfile(name: "Alice", lastMessage: "Hey, how are you?", avatar: "person.fill"),
        ChatProfile(name: "Bob", lastMessage: "Let's meet tomorrow!", avatar: "person.fill"),
        ChatProfile(name: "Charlie", lastMessage: "Did you check the document?", avatar: "person.fill")
    ]

    var body: some View {
        NavigationView {
            List(chats) { chat in
                NavigationLink(destination: ChatDetailView(chatProfile: chat)) {
                    HStack {
                        Image(systemName: chat.avatar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundColor(.gray)

                        VStack(alignment: .leading) {
                            Text(chat.name)
                                .font(.headline)
                            Text(chat.lastMessage)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Chats")
        }
    }
}

struct ChatProfile: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let avatar: String
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
