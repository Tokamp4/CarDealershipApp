//
//  ChatService.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-08.
//

import Foundation
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
}
