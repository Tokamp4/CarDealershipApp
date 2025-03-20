//
//  ChatsView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

let messages = [
        Message(username: "John Doe", message: "Lorem ipsum dolor sit amet", time: "21:13"),
        Message(username: "Jane Smith", message: "Lorem ipsum dolor sit amet", time: "12:15"),
        Message(username: "Michael", message: "Lorem ipsum dolor sit amet", time: "12:02"),
        Message(username: "Alice", message: "Lorem ipsum dolor sit amet", time: "10:40"),
        Message(username: "Bob", message: "Lorem ipsum dolor sit amet", time: "12:30"),
        Message(username: "Charlie", message: "Lorem ipsum dolor sit amet", time: "6:00"),
        Message(username: "Jerry Joy", message: "Lorem ipsum dolor sit amet", time: "12:00"),
        Message(username: "Thiago", message: "Lorem ipsum dolor sit amet", time: "02:30"),
        Message(username: "Allan", message: "Lorem ipsum dolor sit amet", time: "09:00")
    ]

struct ChatsView: View {
    
    @State private var search: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                TextField("Search...", text: $search)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .frame(width: 250, height: 30)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                            
                    )
                    .padding(.top)
                ScrollView{
                    ForEach(messages){msg in
                        NavigationLink(destination: ConversationView(currentUser: msg.username)){
                            MessageCardView(message: msg)
                                .padding(.bottom)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ChatsView()
}
