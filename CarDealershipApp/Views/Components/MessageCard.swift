//
//  MessageCardView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

let message = MessageModel(username: "John Doe", message: "Lorem ipsum dolor sit amet", time: "12:00")

struct MessageCardView: View {
    
    let message: MessageModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("profileImage")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(message.username)
                        .font(.headline)
                    Text(message.message)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text(message.time)
                    .font(.footnote)
                    .padding(.trailing)
                    .foregroundStyle(.blue)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    MessageCardView(message: message)
}
