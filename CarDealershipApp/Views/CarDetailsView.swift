//
//  CarDetailsView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI


struct CarDetailsView: View {
    
    let car: Car
    
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: car.imageURL)) { image in
                image.resizable()
            } placeholder: {
                
                ProgressView()
            }
             
            .scaledToFit()
            .frame(height: 250)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
            
            Text("\(car.manufacturer) \(car.model)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text("Price: \(car.price)")
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack(spacing: 15) {
                Text("Year: \(car.year)")
                Text("Engine: \(car.engineType)")
                Text("Condition: \(car.condition)")
            }
            
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding()
            
            Spacer()
            
            Button(action: {
                //nothing yet
            }) {
                Text("Click Here To Test Drive Now")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
        }
        .navigationTitle(" Car Details ")
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        CarDetailsView(car: Car(
            imageURL: "car1.jpg",
            model: "Model S",
            manufacturer: "Tesla",
            price: "$750,000",
            year: "2022",
            engineType: "Electric",
            condition: "New"
        ))
    }
}
