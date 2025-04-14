//
//  ChatsView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject private var vm = ContactsViewModel()
    
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
                    if vm.conversations.isEmpty {
                        Text("You don't have any contacts. Message sellers!")
                            .padding()
                            .frame(width: 300)
                    } else {
                        ForEach(vm.conversations, id: \.self){convo in
                            NavigationLink(destination: ConversationView(convo: convo, currentUser: vm.currentUser!, isPreview: false)){
                                MessageCardView(convo: convo, userId: vm.currentUser?.id ?? "")
                                    .padding(.bottom)
                            }
                        }
                    }
                }
            }
            .onAppear{
                vm.startListeningToUser()
            }
        }
    }
}

#Preview {
    ContactsView()
}
