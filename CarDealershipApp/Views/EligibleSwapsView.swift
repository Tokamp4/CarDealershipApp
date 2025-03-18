import SwiftUI

struct EligibleSwapsView: View {
    let items: [Car] = [
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6"),
        Car(make: "2025 Audi A6", type: "Sedan, Wagon", imageName: "audi_a6")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Other Eligible Swaps")
                    .font(.largeTitle)
                    .padding()

                List(items) { car in
                    HStack {
                        Image("subaru") // Ensure you have an image named "audi_a6"
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 75)
                            .cornerRadius(10)

                        VStack(alignment: .leading) {
                            Text(car.make)
                                .font(.headline)
                            Text(car.type)
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

struct Car: Identifiable {
    let id = UUID()
    let make: String
    let type: String
    let imageName: String
}

struct EligibleSwapsView_Previews: PreviewProvider {
    static var previews: some View {
        EligibleSwapsView()
    }
}
