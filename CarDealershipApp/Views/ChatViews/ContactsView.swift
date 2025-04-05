//
//  ChatsView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

let messages = [
        MessageModel(username: "John Doe", message: "Lorem ipsum dolor sit amet", time: "21:13"),
        MessageModel(username: "Jane Smith", message: "Lorem ipsum dolor sit amet", time: "12:15"),
        MessageModel(username: "Michael", message: "Lorem ipsum dolor sit amet", time: "12:02"),
        MessageModel(username: "Alice", message: "Lorem ipsum dolor sit amet", time: "10:40"),
        MessageModel(username: "Bob", message: "Lorem ipsum dolor sit amet", time: "12:30"),
        MessageModel(username: "Charlie", message: "Lorem ipsum dolor sit amet", time: "6:00"),
        MessageModel(username: "Jerry Joy", message: "Lorem ipsum dolor sit amet", time: "12:00"),
        MessageModel(username: "Thiago", message: "Lorem ipsum dolor sit amet", time: "02:30"),
        MessageModel(username: "Allan", message: "Lorem ipsum dolor sit amet", time: "09:00")
    ]

struct ContactsView: View {
    
    @StateObject private var vm = ChatViewModel()
    
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
    ContactsView()
}
