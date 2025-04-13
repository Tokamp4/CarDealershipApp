//
//  RecentlyViewedService.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-12.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class RecentlyViewedService {
    static func addToRecentlyViewed(carId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        userRef.getDocument { snapshot, error in
            if var data = snapshot?.data(), var list = data["recentlyViewed"] as? [String] {
                list.removeAll { $0 == carId }
                list.insert(carId, at: 0)
                if list.count > 10 { list = Array(list.prefix(10)) }
                userRef.setData(["recentlyViewed": list], merge: true)
            } else {
                userRef.setData(["recentlyViewed": [carId]], merge: true)
            }
        }
    }

    static func getRecentlyViewed(completion: @escaping ([String]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data(),
               let list = data["recentlyViewed"] as? [String] {
                completion(list)
            } else {
                completion([])
            }
        }
    }
}

