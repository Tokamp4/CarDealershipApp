//
//  ListingsView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI



class CarViewModel: ObservableObject {
    @Published var cars: [CarModel] = []
    
    init() {
        fetchCars()
    }
    
    func fetchCars() {
        self.cars = [
            CarModel(imageURL: "car2", model: "Civic", manufacturer: "Honda", price: "$30,000", year: "2023", engineType: "Hybrid", condition: "New"),
            CarModel(imageURL: "car3", model: "Model 3", manufacturer: "Tesla", price: "$40,000", year: "2022", engineType: "Electric", condition: "New"),
            CarModel(imageURL: "car4", model: "Camry", manufacturer: "Toyota", price: "$28,000", year: "2021", engineType: "Gasoline", condition: "Used"),
            CarModel(imageURL: "car5", model: "Charger", manufacturer: "Dodge", price: "$50,000", year: "2020", engineType: "V8", condition: "Used"),
            CarModel(imageURL: "car6", model: "Outback", manufacturer: "Subaru", price: "$35,000", year: "2023", engineType: "Gasoline", condition: "New"),
            CarModel(imageURL: "car7", model: "CX-5", manufacturer: "Mazda", price: "$32,000", year: "2022", engineType: "Gasoline", condition: "New"),
            CarModel(imageURL: "car8", model: "F-150", manufacturer: "Ford", price: "$60,000", year: "2023", engineType: "Hybrid", condition: "New"),
            CarModel(imageURL: "car9", model: "Altima", manufacturer: "Nissan", price: "$27,000", year: "2021", engineType: "Gasoline", condition: "Used"),
            CarModel(imageURL: "car10", model: "Rogue", manufacturer: "Nissan", price: "$29,000", year: "2022", engineType: "Hybrid", condition: "New")
        ]
    }
}

struct ListingsView: View {
    
//    let cars = [
//        Car(imageURL: "car1", model: "Corolla", manufacturer: "Toyota", price: "$55,000", year: "2022", engineType: "Hybird", condition: "New"),
//        Car(imageURL: "car1", model: "Mustang", manufacturer: "Ford", price: "$45,000", year: "2021", engineType: "V8", condition: "Used")
//    ]
    
    @StateObject private var viewModel = CarViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 15){
                    NavigationLink(destination: ListCarView()){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 170, height: 30)
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
                            .frame(width: 170, height: 30)
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
                        ForEach(viewModel.cars) { car in
                            NavigationLink(destination: CarDetailsView(car: car)) {
                                VStack{
                                    AsyncImage(url: URL(string: car.imageURL)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
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
