import SwiftUI

struct ListCarView: View {
    @State private var model: String = ""
    @State private var manufacturer: String = ""
    @State private var vehicleType: String = ""
    @State private var carCondition: String = ""
    @State private var year: String = ""
    @State private var engineType: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack {
                    Button(action: {
                        // Action for back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                    Spacer()
                    Text("New Vehicle Listing")
                        .font(.title)
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.vertical)

                Button(action: {
                    // Add photos/videos action
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Text("add photos/videos")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                }

                Group {
                    CustomTextField(placeholder: "Model", text: $model)
                    CustomTextField(placeholder: "Manufacturer", text: $manufacturer)
                    CustomTextField(placeholder: "Vehicle Type", text: $vehicleType)
                    CustomTextField(placeholder: "Car Condition", text: $carCondition)
                    CustomTextField(placeholder: "Year", text: $year)
                    CustomTextField(placeholder: "Engine Type", text: $engineType)
                }
                .padding(.top, 10)

                Spacer()

//                HStack {
//                    Spacer()
//                    NavigationLink(destination: Text("Listings")) {
//                        Image(systemName: "cart")
//                            .font(.title)
//                    }
//                    Spacer()
//                    NavigationLink(destination: Text("Program")) {
//                        Image(systemName: "star")
//                            .font(.title)
//                    }
//                    Spacer()
//                    NavigationLink(destination: Text("Chats")) {
//                        Image(systemName: "message")
//                            .font(.title)
//                    }
//                    Spacer()
//                    NavigationLink(destination: Text("Profile")) {
//                        Image(systemName: "person")
//                            .font(.title)
//                    }
//                    Spacer()
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(15)
            }
            .padding()
        }
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.white)
            .border(Color.gray, width: 2)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct ListCarView_Previews: PreviewProvider {
    static var previews: some View {
        ListCarView()
    }
}
