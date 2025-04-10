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
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("profileImage")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(convo.participants[1])
                        .font(.headline)
                    Text(convo.lastMessage)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
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
    MessageCardView(convo: convo)
}
