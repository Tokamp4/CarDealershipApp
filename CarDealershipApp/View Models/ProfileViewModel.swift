//
//  ProfileViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

final class ProfileViewModel: ObservableObject {

    @Published var profileImageUrl: String?
    @Published var recentlyViewed: [CarModel] = []
    @Published var myCars: [CarModel] = []
    @Published var displayName: String? = nil
    @Published var bio: String? = nil

    init() {
        fetchProfileImageUrl()
        fetchRecentlyViewedCars()
        fetchMyCars()
        fetchDisplayName()
    }

    //debugging/
    func fetchMyCars() {
        CarService.fetchCarsForCurrentUser { cars in
            print("Retrieved \(cars.count) car(s) for current user.")
            for car in cars {
                print("Car: \(car.model) | Owner: \(car.userId)")
            }

            DispatchQueue.main.async {
                self.myCars = cars
            }
        }
    }

//    func fetchMyCars() {
//        CarService.fetchCarsForCurrentUser { cars in
//            DispatchQueue.main.async {
//                self.myCars = cars
//            }
//        }
//    }

    func fetchRecentlyViewedCars() {
        RecentlyViewedService.getRecentlyViewed { carIds in
            CarService.fetchCarsByIds(carIds) { cars in
                DispatchQueue.main.async {
                    self.recentlyViewed = cars
                }
            }
        }
    }

    func updateBio(newBio: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).updateData([
            "bio": newBio
        ]) { error in
            if let error = error {
                print("Failed to update bio: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.bio = newBio
                    print("Bio updated.")
                }
            }
        }
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
                print("Image upload failed: \(error.localizedDescription)")
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
    

    func fetchDisplayName() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print(" No UID found.") //debugging
            return
        }

        print("Looking for user with UID: \(uid)") //debugging

        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Firestore error: \(error.localizedDescription)") //debugging
                return
            }

            guard let data = snapshot?.data() else {
                print("No document found for user.") //debugging
                return
            }

            print(" Fetched user data: \(data)") //debugging

            if let name = data["name"] as? String {
                print("Loaded name from Firestore: \(name)")//debugging
                DispatchQueue.main.async {
                    self.displayName = name
                }
            } else {
                print(" 'name' field not found or not a String.")//debugging
            }
        }
    }

}
