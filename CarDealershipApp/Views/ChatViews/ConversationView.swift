//
//  ConversationView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

let convoModel = ConversationModel(participants: ["John Doe", "John Pork"], lastMessage: "hello", lastTimestamp: Date())

struct ConversationView: View {
    
    @StateObject private var vm: ConversationViewModel
    @State private var newMessage: String = ""
    
    init(convo: ConversationModel, currentUser: UserModel, isPreview: Bool) {
        _vm = StateObject(wrappedValue: ConversationViewModel(conversation: convo, currentUser: currentUser, isPreview: isPreview))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                if let otherUser = vm.otherUser {
                    ConversationHeaderView(appUser: otherUser.name, username: "@\(otherUser.username)")
                }
                
                VStack(spacing: 10) {
                    ForEach(vm.messages) { message in
                        HStack {
                            if message.senderId == vm.otherUser?.id {
                                Text(message.text)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                                Spacer()
                            } else {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)
                
                Button {
                    Task {
                        await vm.sendMessage(text: newMessage)
                        newMessage = "" // Clear input
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await vm.fetchOtherUser()
                vm.observeMessages() // 👈 Start listening to new messages
            }
        }
    }
}

#Preview {
    ConversationView(
        convo: convoModel,
        currentUser: UserModel(id: "previewUser", name: "John Doe", username: "johndoe", email: "john@gmail.com"),
        isPreview: true
    )
}
