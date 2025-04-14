//
//  RecentlyViewedSection.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-13.
//

import SwiftUI

struct RecentlyViewedSection: View {
    var cars: [CarModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recently Viewed Listings")
                .font(.headline)

            if cars.isEmpty {
                Text("The listings you view will appear here!")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(cars, id: \.wrappedId) { car in
                            if let urlString = car.photosURL.first, let url = URL(string: urlString) {
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
