//
//  ChatViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import Combine
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    
    @Published var conversations = [ConversationModel]()
    @Published var currentUser: UserModel?
    private var cancellables = Set<AnyCancellable>()
    private var hasStartedListening = false
    
    init() {
    }
    
    func startListeningToUser() {
       guard !hasStartedListening else { return }
       hasStartedListening = true
       
       UserService.shared.$currentUser
           .compactMap { $0 }
           .sink { [weak self] user in
               print("User received: \(user.id)")
               self?.currentUser = user
               self?.listenToConversations()
           }
           .store(in: &cancellables)
   }
    
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
    
    func listenToConversations() {
        guard let uid = currentUser?.id else {
            print("user is nil")
            return
        }
        
        Firestore.firestore()
            .collection("conversations")
            .whereField("participants", arrayContains: uid)
            .order(by: "lastTimestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching conversations: \(error.localizedDescription)")
                }
                
                guard let documents = snapshot?.documents else {
                    print("no conversations found")
                    return
                }
                
                do {
                    self?.conversations = try documents.map{
                        try $0.data(as: ConversationModel.self)
                    }
                } catch {
                    print("failed to decode conversations: \(error.localizedDescription)")
                }
            }
    }
}
