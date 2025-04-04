//
//  AuthenticationManager.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-03-27.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func getAuthenticatedUser() async throws -> UserModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }

        let document = try await Firestore.firestore().collection("users").document(user.uid).getDocument()
        if let data = document.data(), let userModel = try? Firestore.Decoder().decode(UserModel.self, from: data) {
            return userModel
        }

        return UserModel(user: user, name: nil, username: nil) // Fallback
    }
    
    func createUser(name: String, username: String, email: String, password: String) async throws -> UserModel {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = try await uploadUserData(user: authDataResult.user, name: name, username: username)
            return user
        } catch{
            print("User not created \(error.localizedDescription)")
            throw error // to be dealt on the caller
        }
        
    }
    
    private func uploadUserData(user: User, name: String, username: String) async throws -> UserModel {
        let user = UserModel(user: user, name: name, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else {
            throw NSError(domain: "FirestoreEncoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode user data"])
        }
        
        try await Firestore.firestore().collection("users").document(user.uid).setData(userData)
        return user
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
