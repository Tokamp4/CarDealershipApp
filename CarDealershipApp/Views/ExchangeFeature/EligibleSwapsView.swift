import SwiftUI

struct EligibleSwapsView: View {
    let items: [CarModel] = [
        CarModel(imageURL: "audia6", model: "A6", manufacturer: "Audi", price: "$50,000", year: "2025", engineType: "Sedan, Wagon", condition: "New", userId: "test"),
        CarModel(imageURL: "bmw3", model: "3 Series", manufacturer: "BMW", price: "$55,000", year: "2025", engineType: "Sedan, Wagon", condition: "New", userId: "test"),
        CarModel(imageURL: "ferrarif40", model: "F-40", manufacturer: "Ferrari", price: "$230,000", year: "2025", engineType: "Coupe", condition: "New", userId: "test"),
        CarModel(imageURL: "audia6", model: "A6", manufacturer: "Audi", price: "$50,000", year: "2025", engineType: "Sedan, Wagon", condition: "New", userId: "test"),
        CarModel(imageURL: "bmw3", model: "3 Series", manufacturer: "BMW", price: "$55,000", year: "2025", engineType: "Sedan, Wagon", condition: "New", userId: "test"),
        CarModel(imageURL: "ferrarif40", model: "F-40", manufacturer: "Ferrari", price: "$230,000", year: "2025", engineType: "Coupe", condition: "New", userId: "test")
    ]

    var body: some View {
        NavigationView {
            VStack {
                
                
                Text("Other Eligible Swaps")
                    .bold()
                    .font(.largeTitle)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                List(items) { car in
                    HStack {
                        Image(car.imageURL)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 75)
                            .cornerRadius(10)
                            .clipped()

                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(car.year) \(car.manufacturer) \(car.model)")
                                .font(.headline)
                            Text(car.engineType)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(car.price)
                                .font(.subheadline)
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EligibleSwapsView_Previews: PreviewProvider {
    static var previews: some View {
        EligibleSwapsView()
    }
}
