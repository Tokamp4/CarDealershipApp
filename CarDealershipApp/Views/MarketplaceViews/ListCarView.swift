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
                    Text("New Vehicle Listing")
                        .font(.title)
                        .padding(.horizontal)

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
                    TextField("Model", text: $model)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Manufacturer", text: $manufacturer)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Vehicle Type",text: $vehicleType)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Car Condition", text: $carCondition)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Year",text:$year)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Engine", text: $engineType)
                        .modifier(RoundedTextFieldStyle())
                }
                .padding(3)
                Button(action: {
                    //nothing yet
                }) {
                    Text("Post Vehicle")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()

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
