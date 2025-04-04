//
//  SignUpModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-03-26.
//

import Foundation
import FirebaseAuth

struct UserModel: Identifiable,Hashable,Codable {
    
    let id: String
    var name: String
    var username: String
    var email: String
    //var profileImageName: String?
    var isCurrentUser: Bool {
            guard let currentUid = Auth.auth().currentUser?.uid else { return false }
            return id == currentUid
        }
}
