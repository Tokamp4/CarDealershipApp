//
//  Message.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-18.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let username: String
    let message: String
    let time: String
}
