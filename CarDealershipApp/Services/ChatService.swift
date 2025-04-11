//
//  ChatService.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-08.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatService {
    
    static func fetchConversations(uid: String) async throws -> [ConversationModel] {
            let query = Firestore.firestore()
                .collection("conversations")
                .whereField("participants", arrayContains: uid)
                .order(by: "lastTimestamp", descending: true)
            let snapshot = try await query.getDocuments()
                
            let conversations = try snapshot.documents.compactMap { doc in
                try doc.data(as: ConversationModel.self)
            }
            
            return conversations
        }
    
    static func fetchMessages(convoId: String) async throws -> [MessageModel] {
        let snapshot = try await Firestore.firestore()
            .collection("conversations")
            .document(convoId)
            .collection("messages")
            .order(by: "timestamp", descending: false)
            .getDocuments()
        
        return try snapshot.documents.map { try $0.data(as: MessageModel.self) }
    }
    
    static func sendMessage(conversationId: String, message: MessageModel) async throws {
            let db = Firestore.firestore()
            let messagesRef = db.collection("conversations").document(conversationId).collection("messages")
            
            try messagesRef.addDocument(from: message)
            
            // Update the conversation metadata
            let convoRef = db.collection("conversations").document(conversationId)
            try await convoRef.updateData([
                "lastMessage": message.text,
                "lastTimestamp": message.timestamp
            ])
        }

}
