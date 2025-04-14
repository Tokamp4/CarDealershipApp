
//
//  CarViewModel.swift
//  CarDealershipApp
//
//  Created by Tsiory Rakotoarimanana on 2025-04-10.
//

//import Foundation
//
//import Firebase
//import FirebaseFirestore
//
//import UIKit
//
//class CarViewModel: ObservableObject {
//    @Published var cars: [CarModel] = []
//    private let service = CarService()
//
//    init() {
//        fetchCars()
//    }
//
//    func fetchCars() {
//        service.fetchCars { [weak self] fetchedCars in
//            DispatchQueue.main.async {
//                self?.cars = fetchedCars
//            }
//        }
//    }
//
//    func addCar(_ car: CarModel) {
//        service.addCar(car) { success in
//            if success {
//                self.fetchCars()
//            }
//        }
//    }
//
//    func listNewCar(image: UIImage, model: String, manufacturer: String, price: String, year: String, engineType: String, condition: String) {
//        ImageUploader.uploadImage(image) { result in
//            switch result {
//            case .success(let imageURL):
//                let newCar = CarModel(
//                    imageURL: imageURL,
//                    model: model,
//                    manufacturer: manufacturer,
//                    price: price,
//                    year: year,
//                    engineType: engineType,
//                    condition: condition
//                )
//
//                FirestoreService().uploadCar(newCar) { result in
//                    switch result {
//                    case .success():
//                        print("Car listed successfully!")
//                        DispatchQueue.main.async {
//                            self.fetchCars()
//                        }
//                    case .failure(let error):
//                        print("Failed to upload car: \(error.localizedDescription)")
//                    }
//                }
//            case .failure(let error):
//                print("Failed to upload image: \(error.localizedDescription)")
//            }
//        }
//    }
//}
// CarViewModel.swift
// CarDealershipApp
//
// Created by Tsiory Rakotoarimanana on 2025-04-10.

import Foundation
import Firebase
import FirebaseFirestore
import Combine

class ListingsViewModel: ObservableObject {
    @Published var cars = [CarModel]()
    @Published var currentUser: UserModel?
    private let service = CarService()
    private var cancellables = Set<AnyCancellable>()
    private var hasStartedListening = false
        
    init() {
    }
    
    func startListeningToUser() {
           guard !hasStartedListening else { return }
           hasStartedListening = true
           
           UserService.shared.$currentUser
               .compactMap { $0 }
               .sink { [weak self] user in
                   print("User received: \(user.id)")
                   self?.currentUser = user
                   self?.listenToListings()
               }
               .store(in: &cancellables)
       }
    
    func listenToListings() {
        guard let uid = currentUser?.id else {
            print("user is nil")
            return
        }
        
        Firestore.firestore()
            .collection("cars")
            .whereField("userId", isNotEqualTo: uid)
//            .order(by: "timeStamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching cars: \(error.localizedDescription)")
                }
                
                guard let documents = snapshot?.documents else {
                    print("no cars found")
                    return
                }
                print("Snapshot: \(String(describing: snapshot))")
                print("Documents: \(String(describing: snapshot?.documents))")
                do {
                    self?.cars = try documents.map{
                        try $0.data(as: CarModel.self)
                    }
                } catch {
                    print("failed to decode cars: \(error.localizedDescription)")
                }
            }
    }
    
//    func fetchCars() {
//        service.fetchCars { [weak self] fetchedCars in
//            DispatchQueue.main.async {
//                self?.cars = fetchedCars
//            }
//        }
//    }
//    
//    func addCar(_ car: CarModel) {
//        service.addCar(car) { success in
//            if success {
//                self.fetchCars()
//            }
//        }
//    }
    
    // just to test
    func loadDummyData() {
        self.cars = [
            CarModel(
                id: "1",
                photosURL: ["https://via.placeholder.com/150"],
                model: "Civic",
                manufacturer: "Honda",
                price: "$10,000",
                vehicleType: "",
                year: "2018",
                engineType: "Gasoline",
                condition: "Used"
                , userId: "test"
            ),
            CarModel(
                id: "2",
                photosURL: ["https://via.placeholder.com/150"],
                model: "Model 3",
                manufacturer: "Tesla",
                price: "$35,000",
                vehicleType: "",
                year: "2021",
                engineType: "Electric",
                condition: "New"
                , userId: "test"
            ),
            CarModel(
                id:"3",
                photosURL: ["https://via.placeholder.com/150"],
                model: "Corolla",
                manufacturer: "Toyota",
                price: "$9,500",
                vehicleType: "",
                year: "2016",
                engineType: "Gasoline",
                condition: "Used"
                , userId: "test"
            )
        ]
    }
    
    
}
