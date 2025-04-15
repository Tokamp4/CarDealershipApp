//
//  YourCarDetailsView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-14.
//

import SwiftUI
import Firebase

struct YourCarDetailsView: View {
    let car: CarModel
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let urlString = car.photosURL.first, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                }

                Group {
                    Text("Model: \(car.model)")
                    Text("Manufacturer: \(car.manufacturer)")
                    Text("Price: \(car.price)")
                    Text("Type: \(car.vehicleType)")
                    Text("Year: \(car.year)")
                    Text("Condition: \(car.condition)")
                    Text("Engine: \(car.engineType)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                Button("Mark as Sold") {
                    showDeleteAlert = true
                }
                .foregroundColor(.red)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Your Car")
        .alert("Are you sure you want to mark this car as sold?", isPresented: $showDeleteAlert) {
            Button("Yes, Mark as Sold", role: .destructive) {
                deleteCar()
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    func deleteCar() {
        guard let carId = car.id else { return }

        Firestore.firestore().collection("cars").document(carId).delete { error in
            if let error = error {
                print("❌ Failed to delete car: \(error.localizedDescription)")
            } else {
                print("✅ Car marked as sold!")
                NotificationCenter.default.post(name: .didDeleteCar, object: nil)
                dismiss()
            }
        }
    }

}

#Preview {
    YourCarDetailsView(car:car)
}
