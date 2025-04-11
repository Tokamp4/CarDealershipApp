
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
import UIKit

class CarViewModel: ObservableObject {
    @Published var cars: [CarModel] = []
    private let service = CarService()
    
    init() {
        //fetchCars()
        loadDummyData()
    }
    
    func fetchCars() {
        service.fetchCars { [weak self] fetchedCars in
            DispatchQueue.main.async {
                self?.cars = fetchedCars
            }
        }
    }
    
    func addCar(_ car: CarModel) {
        service.addCar(car) { success in
            if success {
                self.fetchCars()
            }
        }
    }
    
    // just to test
    func loadDummyData() {
        self.cars = [
            CarModel(
                imageURL: "https://via.placeholder.com/150",
                model: "Civic",
                manufacturer: "Honda",
                price: "$10,000",
                year: "2018",
                engineType: "Gasoline",
                condition: "Used"
            ),
            CarModel(
                imageURL: "https://via.placeholder.com/150",
                model: "Model 3",
                manufacturer: "Tesla",
                price: "$35,000",
                year: "2021",
                engineType: "Electric",
                condition: "New"
            ),
            CarModel(
                imageURL: "https://via.placeholder.com/150",
                model: "Corolla",
                manufacturer: "Toyota",
                price: "$9,500",
                year: "2016",
                engineType: "Gasoline",
                condition: "Used"
            )
        ]
    }
    
    func listNewCar(image: UIImage, model: String, manufacturer: String, price: String, year: String, engineType: String, condition: String) {
     ImageUploader.uploadImage(image) { result in
            switch result {
            case .success(let imageURL):
                let newCar = CarModel(
                    imageURL: imageURL,
                    model: model,
                    manufacturer: manufacturer,
                    price: price,
                    year: year,
                    engineType: engineType,
                    condition: condition
                )

                FirestoreService().uploadCar(newCar) { result in
                    switch result {
                    case .success():
                        print("Car listed successfully!")
                        DispatchQueue.main.async {
                            self.fetchCars()
                        }
                    case .failure(let error):
                        print("Failed to upload car: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Failed to upload image: \(error.localizedDescription)")
            }
        }
    }
}
