//
//  ConversationViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-11.
//

import Foundation
import Combine
import FirebaseFirestore

class ConversationViewModel: ObservableObject {
    
    @Published var messages: [MessageModel] = []
    @Published var otherUser: UserModel?
    
    private let conversation: ConversationModel
    private let currentUser: UserModel
    private var listener: ListenerRegistration?
    
    init(conversation: ConversationModel, currentUser: UserModel, isPreview: Bool = false) {
        self.conversation = conversation
        self.currentUser = currentUser
        
        if !isPreview {
            Task {
                await fetchMessages()
                await fetchOtherUser()
            }
            observeMessages()
        }
        if isPreview {
            self.messages = [
                    MessageModel(id: "1", senderId: currentUser.id, text: "Hey there!", timestamp: Date(), isRead: true),
                    MessageModel(id: "2", senderId: "otherUser123", text: "Hi! How can I help you?", timestamp: Date(), isRead: false)
                ]
                self.otherUser = UserModel(id: "otherUser123", name: "Jane Seller", username: "janeseller", email: "jane@example.com")

        }
    }
    
    deinit {
        listener?.remove()
    }
    
    var convoId: String {
        conversation.id ?? ""
    }
    
    @MainActor
    private func fetchMessages() async {
        do {
            messages = try await ChatService.fetchMessages(convoId: convoId)
        } catch {
            print("Failed to fetch messages: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    public func sendMessage(text: String) async {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let newMessage = MessageModel(
            id: nil,
            senderId: currentUser.id,
            text: text,
            timestamp: Date(),
            isRead: false
        )

        do {
            guard let convoId = conversation.id else {
                print("Conversation ID is nil.")
                return
            }

            try await ChatService.sendMessage(conversationId: convoId, message: newMessage)

            // Optional: append manually while waiting for real-time update
//            DispatchQueue.main.async {
//                self.messages.append(newMessage)
//            }
        } catch {
            print("Error sending message: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    public func fetchOtherUser() async {
        guard let otherUserId = conversation.participants.first(where: { $0 != currentUser.id }) else { return }
        do {
            otherUser = try await UserService.shared.fetchUser(withId: otherUserId)
        } catch {
            print("Failed to fetch other user: \(error.localizedDescription)")
        }
    }
    
    public func observeMessages() {
        guard let convoId = conversation.id else { return }

        let db = Firestore.firestore()
        let ref = db.collection("conversations").document(convoId).collection("messages")
            .order(by: "timestamp")

        listener = ref.addSnapshotListener { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else { return }

            self?.messages = documents.compactMap { doc in
                try? doc.data(as: MessageModel.self)
            }
        }
    }
}
