//
//  MessageCardView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

let convo = ConversationModel(participants: ["John Doe", "John Pork"], lastMessage: "hello", lastTimestamp: Date())


struct MessageCardView: View {
    let convo: ConversationModel
    var userId: String
    
    @State private var otherUserName: String = "Loading..."
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(otherUserName)
                        .font(.headline)
                        .padding(.leading)
                    Text(convo.lastMessage)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.leading)
                        .lineLimit(1)
                }
                Spacer()
                Text(convo.lastTimestamp.formatted())
                    .font(.footnote)
                    .padding(.trailing)
                    .foregroundStyle(.blue)
            }
        }
        .padding(.horizontal)
        .onAppear {
            fetchOtherUser()
        }
    }
    
    private func fetchOtherUser() {
        let otherParticipantId = convo.participants.first { $0 != userId } ?? "Unknown"
        
        ChatService.fetchUserNameById(userId: otherParticipantId) { name in
            DispatchQueue.main.async {
                self.otherUserName = name ?? "Unknown User"
            }
        }
    }
}

#Preview {
    MessageCardView(convo: convo, userId: "John Doe")
}
