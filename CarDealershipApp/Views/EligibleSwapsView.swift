import SwiftUI

struct EligibleSwapsView: View {
    let items: [Car] = [
        Car(imageURL: "audi_a6", model: "A6", manufacturer: "Audi", price: "$50,000", year: "2025", engineType: "Hybrid", condition: "New"),
        Car(imageURL: "audi_a6", model: "A6", manufacturer: "Audi", price: "$50,000", year: "2025", engineType: "Hybrid", condition: "New")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Other Eligible Swaps")
                    .font(.largeTitle)
                    .padding()

                List(items) { car in
                    HStack {
                        Image(car.imageURL)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 75)
                            .cornerRadius(10)

                        VStack(alignment: .leading) {
                            Text("\(car.manufacturer) \(car.model)")
                                .font(.headline)
                            Text(car.condition)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct EligibleSwapsView_Previews: PreviewProvider {
    static var previews: some View {
        EligibleSwapsView()
    }
}
