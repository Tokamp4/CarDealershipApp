//
//  AuthenticationManager.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-03-27.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    
    static let shared = AuthService()
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    
    @MainActor
    func login(email: String,password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            //try await UserService.shared.fetchCurrentUser()
        } catch {
            print("failed to create user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(name: String, username: String, email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(uid: result.user.uid, name: name, username: username, email: email)
        } catch{
            print("User not created \(error.localizedDescription)")
        }
        
    }
    
    
    
    @MainActor
    private func uploadUserData(uid: String, name: String, username: String, email: String) async throws {
        let user = UserModel(id: uid, name: name, username: username, email: email)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        
        try await Firestore.firestore().collection("users").document(uid).setData(userData)
        //UserService.shared.currentUser = user
    }
    
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        //UserService.shared.reset()
    }
}
