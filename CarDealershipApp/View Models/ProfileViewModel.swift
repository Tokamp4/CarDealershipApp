//
//  ProfileViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

final class ProfileViewModel: ObservableObject {
    
    @Published var profileImageUrl: String?

    init() {
        fetchProfileImageUrl()
    }

    func signOut() {
        AuthService.shared.signOut()
        UserService.shared.reset()
    }

    func uploadProfileImage(image: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        ImageUploader.uploadImage(image) { result in
            switch result {
            case .success(let imageUrl):
                DispatchQueue.main.async {
                    self.profileImageUrl = imageUrl
                }

                let db = Firestore.firestore()
                db.collection("users").document(uid).setData([
                    "profileImageUrl": imageUrl
                ], merge: true)

            case .failure(let error):
                print("Image upload was not sucessful!: \(error.localizedDescription)")
            }
        }
    }

    func fetchProfileImageUrl() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data(), let url = data["profileImageUrl"] as? String {
                DispatchQueue.main.async {
                    self.profileImageUrl = url
                }
            }
        }
    }
}
