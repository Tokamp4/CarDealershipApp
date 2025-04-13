//
//  UserService.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserService: ObservableObject{
    
    static let shared = UserService()
    @Published var currentUser: UserModel?
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        self.currentUser = try snapshot.data(as: UserModel.self)
    }
    
    @MainActor
    func fetchUser(withId uid: String) async throws -> UserModel {
        let doc = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try doc.data(as: UserModel.self)
    }
    
    func reset() {
        self.currentUser = nil
    }
    
}
