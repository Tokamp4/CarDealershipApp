//
//  UserService.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserService: ObservableObject {
    
    static let shared = UserService()
    @Published var user: UserModel?
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        self.user = try snapshot.data(as: UserModel.self)
    }
    
    func reset() {
        self.user = nil
    }
    
}
