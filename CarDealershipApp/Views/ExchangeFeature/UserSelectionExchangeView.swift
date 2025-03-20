import SwiftUI

struct CarSelectionView: View {
    @State private var selectedCar: String = "Tesla Model 3"
    @State private var carImage: String? = nil
    @State private var isImagePickerPresented = false
    let carOptions = ["Tesla Model 3", "Ford Mustang", "BMW M3", "Audi A4", "Mercedes C-Class"]
    let assetImages = ["subaru", "car_mustang", "car_bmw", "car_audi", "car_mercedes"] // Add asset images
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Choose a Car from Profile")
                .font(.title)
                .bold()
                .padding()
            
            Picker("Car", selection: $selectedCar) {
                ForEach(carOptions, id: \ .self) { car in
                    Text(car).tag(car)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            
            if let carImage = carImage {
                Image(carImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            }
            
            Text("Or")
                .font(.title)
                .padding()
            
            Button(action: {}) {
                Text("Upload Car Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {}) {
                //need to add
                Text("Save Selection")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}

struct CarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CarSelectionView()
    }
}
