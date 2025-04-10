//
//  ChatsView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject private var vm = ChatViewModel()
    
    @State private var search: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
//                TextField("Search...", text: $search)
//                    .padding()
//                    .background(Color.gray.opacity(0.1))
//                    .frame(width: 250, height: 30)
//                    .cornerRadius(10)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.gray, lineWidth: 1)
//                            
//                    )
//                    .padding(.top)
                ScrollView{
                    ForEach(vm.conversations, id: \.self){convo in
                        NavigationLink(destination: ConversationView(currentUser: "user1")){
                            MessageCardView(convo: convo)
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
