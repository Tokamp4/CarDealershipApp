//
//  ListingsView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI



//class CarViewModel: ObservableObject {
//    @Published var cars: [Car] = []
//    
//    init() {
//        fetchCars()
//    }
//    
//    func fetchCars() {
//        self.cars = [
//            Car(imageURL: "car1", model: "Corollla", manufacturer: "Toyota", price: "$55,000", year: "2022", engineType: "Hybird", condition: "New"),
//            Car(imageURL: "car1", model: "Mustang", manufacturer: "Ford", price: "$45,000", year: "2021", engineType: "V8", condition: "Used")
//        ]
//    }
//}

struct ListingsView: View {
    
    let cars = [
        Car(imageURL: "car1", model: "Corolla", manufacturer: "Toyota", price: "$55,000", year: "2022", engineType: "Hybird", condition: "New"),
        Car(imageURL: "car1", model: "Mustang", manufacturer: "Ford", price: "$45,000", year: "2021", engineType: "V8", condition: "Used")
    ]
    
    //@StateObject private var viewModel = CarViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 30){
                    Button{
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 150, height: 30)
                            .overlay(
                                HStack{
                                    Image(systemName: "tag.fill")
                                        .foregroundStyle(.white)
                                    Text("Sell")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                               
                            )
                    }
                    Button{
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 150, height: 30)
                            .overlay(
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.white)
                                    Text("Search")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                               
                            )
                    }
                }
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(cars) { car in
                            NavigationLink(destination: CarDetailsView(car: car)) {
                                VStack{
                                    Image("car1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 180, height: 140)
                                        
                                    HStack{
                                        Text(car.model)
                                            .foregroundStyle(.black)
                                            .lineLimit(1)

                                            
                                        Text(car.price)
                                    }
                                    .padding(.bottom,5)
                                    
                                        
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.gray, lineWidth: 4) // Blue border with 3pt width
                                )
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(Text("Marketplace"))
        }
    }
}

struct ListingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView()
    }
}
