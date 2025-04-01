//
//  SignUpModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-03-26.
//

import Foundation
import FirebaseAuth

struct UserModel: Codable, Equatable {
    let uid: String
    let name: String?
    let username: String?
    let email: String?
    
    init(user: User, name: String?, username: String?){
        self.uid = user.uid
        self.name = name
        self.username = username
        self.email = user.email ?? "No email"
    }
}
