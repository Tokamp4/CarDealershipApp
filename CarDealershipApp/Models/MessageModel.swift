//
//  Message.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import Foundation
import FirebaseFirestore

struct MessageModel: Identifiable, Decodable, Encodable{
    @DocumentID var id: String?
       let senderId: String
       let text: String
       let timestamp: Date
       let isRead: Bool
}
