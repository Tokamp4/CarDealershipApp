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
                    Text("Description:")
                        .foregroundStyle(.black)
                    Text("Year: \(car.year)")
                    Text("Condition: \(car.condition)")
                    Text("Car Type: ")
                    Text("Engine: \(car.engineType)")
                    Text("Acceleration: ")
                    Text("Transmission: ")
                    Text("Safety Features: ")
                }
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.leading,20)
                
                Spacer()
            }
            .padding()
            VStack(alignment: .leading){
                Text("Seller ")
                    .font(.system(size: 20))
                HStack(alignment: .center){
                    Image("profileImage")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                    Text("John Doe")
                        .font(.system(size: 20, weight: .semibold))
                    NavigationLink(destination: ConversationView(currentUser: "user1")){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 170, height: 30)
                            .overlay(
                                HStack{
                                    Image(systemName: "message")
                                        .foregroundStyle(.white)
                                    Text("Message")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                                
                            )
                    }
                    
                }
            }
            
            
            Spacer()
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
