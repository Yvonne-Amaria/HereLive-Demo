//
//  ChatDetailView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct ChatDetailView: View {
    var chatProfile: ChatProfile
    @State private var messageText = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10) { _ in
                        HStack {
                            Text("Hello!")
                                .padding()
                                .background(Color.green.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.green)
                }
            }
        }
        .navigationTitle(chatProfile.name)
        .padding()
    }

    private func sendMessage() {
        // Handle the send action here
        print("Message sent: \(messageText)")
        messageText = ""  // Clear the input after send
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView(chatProfile: ChatProfile(name: "Alice", lastMessage: "Hello there!", avatar: "person.fill"))
    }
}
