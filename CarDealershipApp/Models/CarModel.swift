//
//  Car.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import Foundation

struct CarModel: Identifiable {
    let id = UUID()
    let imageURL: String
    let model: String
    let manufacturer: String
    let price: String
    let year: String
    let engineType: String
    let condition: String
}
