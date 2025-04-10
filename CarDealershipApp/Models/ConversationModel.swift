//
//  ConversationModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import FirebaseFirestore

struct ConversationModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
        let participants: [String]
        let lastMessage: String
        let lastTimestamp: Date
    
}
