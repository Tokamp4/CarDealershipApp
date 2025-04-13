//
//  CarCardView.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-13.
//

import SwiftUI

let car = CarModel(photosURL: [""], model: "", manufacturer: "", price: "", vehicleType: "", year: "", engineType: "", condition: "", userId: "")

struct CarCardView: View {
    let car: CarModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: car.photosURL.first ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 180, height: 140)
            .cornerRadius(10)

            HStack {
                Text(car.model)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                Spacer()
                Text(car.price)
            }
            .font(.subheadline)
            .padding(.horizontal, 8)
            .padding(.bottom, 5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 2)
        )
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}

#Preview {
    CarCardView(car: car)
}
