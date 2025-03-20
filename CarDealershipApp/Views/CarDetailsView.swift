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
//            AsyncImage(url: URL(string: car.imageURL)) { image in
//                image.resizable()
//            } placeholder: {
//                
//                ProgressView()
//            }
            ImageCarousel(images: ["car1", "car1", "car1"])
                
            
            Text("\(car.manufacturer) \(car.model)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text("Price: \(car.price)")
                .font(.headline)
                .foregroundColor(.gray)
                
            HStack{
                VStack(alignment: .leading, spacing: 5) {
                    Text("Description")
                        .foregroundStyle(.black)
                    Text("Year: \(car.year)")
                    Text("Engine: \(car.engineType)")
                    Text("Condition: \(car.condition)")
                }
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.leading,20)
                
                Spacer()
            }
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
