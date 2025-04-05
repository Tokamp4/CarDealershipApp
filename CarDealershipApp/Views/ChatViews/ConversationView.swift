//
//  ConversationView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var chatMessages: [MessageModel] = [
        MessageModel(username: "user1", message: "Lorem ipsum dolor sit amet", time: "21:13"),
        MessageModel(username: "user2", message: "Lorem ipsum dolor sit amet", time: "12:15")
    ]
}


struct ConversationView: View {
    
    @StateObject private var viewModel = MessageViewModel()
    @State private var newMessage: String = ""
    var currentUser: String
    
    var body: some View {
        VStack{
            ScrollView{
                ConversationHeaderView(appUser: "John Doe", username: "@J0hnD03")
                VStack(spacing: 10) {
//                    ForEach(viewModel.chatMessages) { message in
//                        HStack {
//                            if message.username == currentUser {
//                                Spacer()
//                                Text(message.text)
//                                    .padding()
//                                    .background(Color.blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(15)
//                                    .frame(maxWidth: 250, alignment: .trailing)
//                            }
//                            else {
//                                Text(message.text)
//                                    .padding()
//                                    .background(Color.gray.opacity(0.2))
//                                    .cornerRadius(15)
//                                    .frame(maxWidth: 250, alignment: .leading)
//                                Spacer()
//                            }
//                        }
//                    }
                }
                .padding()
                
            }
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)
                
                Button{
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ConversationView(currentUser: "user1")
}
