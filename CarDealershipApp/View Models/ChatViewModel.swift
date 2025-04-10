//
//  ChatViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    
    init() {
        UserService.shared.$currentUser
            .compactMap { $0 } // filters out nil values
            .sink { [weak self] user in
                self?.currentUser = user
                
                Task {
                    await self?.fetchConversations()
                }
            }
            .store(in: &cancellables)
    }
    
    @Published var conversations = [ConversationModel]()
    @Published var currentUser: UserModel?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchConversations() async{
        do{
            guard let uid = currentUser?.id else{
                print("User is empty")
                return
            }
            print("user is: \(uid)")
            self.conversations = try await ChatService.fetchConversations(uid: uid)
        } catch{
            print(error.localizedDescription)
        }
        
    }
}
