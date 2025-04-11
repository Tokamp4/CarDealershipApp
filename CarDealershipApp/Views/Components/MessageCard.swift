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
    
    var body: some View {
        
        let otherParticipantId = convo.participants.first { $0 != userId } ?? "Unknown"
        
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(otherParticipantId)
                        .font(.headline)
                        .padding(.leading)
                    Text(convo.lastMessage)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.leading)
                }
                Spacer()
                Text(convo.lastTimestamp.formatted())
                    .font(.footnote)
                    .padding(.trailing)
                    .foregroundStyle(.blue)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    MessageCardView(convo: convo, userId: "John Doe")
}
