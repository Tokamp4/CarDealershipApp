//
//  UserCarsSection.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-13.
//

import SwiftUI

struct UserCarsSection: View {
    var cars: [CarModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Cars")
                .font(.headline)

            if cars.isEmpty {
                Text("Your car listings will appear here when you have some.")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(cars, id: \.wrappedId) { car in
                            if let urlString = car.imageURL, let url = URL(string: urlString) {
                                NavigationLink(destination: CarDetailsView(car: car)) {
                                    AsyncImage(url: url) { phase in
                                        if let image = phase.image {
                                            image.resizable().scaledToFill()
                                        } else if phase.error != nil {
                                            Color.red
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 180, height: 100)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
