//
//  ListingsView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI



class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    
    init() {
        fetchCars()
    }
    
    func fetchCars() {
        self.cars = [
            Car(imageURL: "car1.jpg", model: "Corollla", manufacturer: "Toyota", price: "$55,000", year: "2022", engineType: "Hybird", condition: "New"),
            Car(imageURL: "car2.jpg", model: "Mustang", manufacturer: "Ford", price: "$45,000", year: "2021", engineType: "V8", condition: "Used")
        ]
    }
}

struct ListingsView: View {
    @StateObject private var viewModel = CarViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.cars) { car in
                NavigationLink(destination: CarDetailsView(car: car)) {
                    HStack {
                        AsyncImage(url: URL(string: car.imageURL)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .frame(width: 80, height: 60)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text("\(car.manufacturer) \(car.model)")
                                .font(.headline)
                            Text("Price: \(car.price)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Car Listings")
        }
    }
}

struct ListingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView()
    }
}
