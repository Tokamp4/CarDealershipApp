//
//  FireStoreService.swift
//  CarDealershipApp
//
//  Created by Nizmee Wuvais on 2025-04-08.
//

import Firebase
class FirestoreService {
    private let db = Firestore.firestore()
    
    func uploadCar(_ car: CarModel, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("cars").addDocument(from: car) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

