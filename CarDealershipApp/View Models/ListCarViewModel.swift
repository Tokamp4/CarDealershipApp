//
//  ListCarViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-13.
//

import Foundation
import SwiftUI

class ListCarViewModel: ObservableObject {
    @Published var model: String = ""
    @Published var manufacturer: String = ""
    @Published var price: String = ""
    @Published var vehicleType: String = ""
    @Published var year: String = ""
    @Published var engineType: String = ""
    @Published var condition: String = ""

    @Published var firebaseImages: [String] = []
    @Published var selectedImages: [String] = []

    private let carService = CarService()

    func fetchFirebaseImages() {
        carService.fetchFirebaseImages { [weak self] urls in
            DispatchQueue.main.async {
                self?.firebaseImages = urls
            }
        }
    }

    func toggleImageSelection(url: String) {
        if selectedImages.contains(url) {
            selectedImages.removeAll { $0 == url }
        } else {
            selectedImages.append(url)
        }
    }

    func uploadCarData() async {
        let car = CarModel(
            photosURL: selectedImages,
            model: model,
            manufacturer: manufacturer,
            price: "$0",
            vehicleType: vehicleType,
            year: year,
            engineType: engineType,
            condition: condition,
            userId: "TODO-UserID"
        )

        do {
            try await carService.uploadCar(car: car, photoURLs: selectedImages)
            print("Car uploaded successfully.")
        } catch {
            print("Upload failed: \(error.localizedDescription)")
        }
    }
}
