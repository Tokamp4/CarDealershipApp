import SwiftUI
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

////EDUARDO VERSION

struct ListCarView: View {
    @StateObject private var viewModel = ListCarViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
       
        
        ScrollView {
            VStack(spacing: 10) {
                Text("New Vehicle Listing")
                    .font(.title)
                    .padding(.horizontal)

                Button(action: {
                    viewModel.fetchFirebaseImages()
                }) {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        Text("Browse from Library")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }

                if !viewModel.firebaseImages.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.firebaseImages, id: \.self) { url in
                                let isSelected = viewModel.selectedImages.contains(url)
                                AsyncImage(url: URL(string: url)) { image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.2)
                                }
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    viewModel.toggleImageSelection(url: url)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }

                Group {
                    TextField("Model", text: $viewModel.model).modifier(RoundedTextFieldStyle())
                    TextField("Manufacturer", text: $viewModel.manufacturer).modifier(RoundedTextFieldStyle())
                    TextField("Price", text: $viewModel.price).modifier(RoundedTextFieldStyle())
                    TextField("Vehicle Type", text: $viewModel.vehicleType).modifier(RoundedTextFieldStyle())
                    TextField("Year", text: $viewModel.year).modifier(RoundedTextFieldStyle())
                    TextField("Engine Type", text: $viewModel.engineType).modifier(RoundedTextFieldStyle())
                    TextField("Car Condition", text: $viewModel.condition).modifier(RoundedTextFieldStyle())
                }

                Button("Post Vehicle") {
                    Task {
                        if !viewModel.model.isEmpty &&
                            !viewModel.manufacturer.isEmpty &&
                            !viewModel.price.isEmpty &&
                            !viewModel.vehicleType.isEmpty &&
                            !viewModel.year.isEmpty &&
                            !viewModel.engineType.isEmpty &&
                            !viewModel.condition.isEmpty {

                            await viewModel.uploadCarData()
                            NotificationCenter.default.post(name: .didUploadCar, object: nil)
                            dismiss()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

            }
            .padding()
        }
    }
}



////TSIORY VERSION



//struct ListCarView: View {
//    @State private var model: String = ""
//    @State private var manufacturer: String = ""
//    @State private var vehicleType: String = ""
//    @State private var carCondition: String = ""
//    @State private var year: String = ""
//    @State private var engineType: String = ""
//
//    @State private var firebaseImages: [String] = [] // URLs from Firebase
//    @State private var selectedFirebaseImageURLs: [String] = []
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 10) {
//                Text("New Vehicle Listing")
//                    .font(.title)
//                    .padding(.horizontal)
//
//                // Button to fetch Firebase images
//                Button(action: {
//                    print("Fetch Firebase images button pressed.") // Add log
//                    fetchFirebaseImages()
//                }) {
//                    VStack {
//                        Image(systemName: "photo.on.rectangle.angled")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .foregroundColor(.blue)
//                        Text("Browse from Library")
//                            .foregroundColor(.blue)
//                            .font(.headline)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 3)
//                }
//                Spacer()
//
//                // Firebase image previews
//                if !firebaseImages.isEmpty {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(firebaseImages, id: \.self) { urlString in
//                                let isSelected = selectedFirebaseImageURLs.contains(urlString)
//                                AsyncImage(url: URL(string: urlString)) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                } placeholder: {
//                                    Color.gray.opacity(0.2)
//                                }
//                                .frame(width: 100, height: 100)
//                                .clipped()
//                                .cornerRadius(8)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
//                                )
//                                .onTapGesture {
//                                    if isSelected {
//                                        selectedFirebaseImageURLs.removeAll { $0 == urlString }
//                                    } else {
//                                        selectedFirebaseImageURLs.append(urlString)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.vertical)
//                    }
//                }
//
//                // Text fields
//                Group {
//                    TextField("Model", text: $model).modifier(RoundedTextFieldStyle())
//                    TextField("Manufacturer", text: $manufacturer).modifier(RoundedTextFieldStyle())
//                    TextField("Vehicle Type", text: $vehicleType).modifier(RoundedTextFieldStyle())
//                    TextField("Car Condition", text: $carCondition).modifier(RoundedTextFieldStyle())
//                    TextField("Year", text: $year).modifier(RoundedTextFieldStyle())
//                    TextField("Engine", text: $engineType).modifier(RoundedTextFieldStyle())
//                }
//                Spacer()
//
//                // Upload Button
//                Button("Post Vehicle") {
//                    uploadCarData(photoURLs: selectedFirebaseImageURLs)
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            .padding()
//        }
//    }
//
//    // Firebase Image Fetcher
//    func fetchFirebaseImages() {
//        print("Fetching Firebase images...") // Add log
//        let storageRef = Storage.storage().reference().child("car_images")
//
//        storageRef.listAll { result, error in
//            if let error = error {
//                print("Failed to list Firebase images: \(error.localizedDescription)")
//                return
//            }
//
//            // Safely unwrap the result
//            if let items = result?.items {
//                for item in items {
//                    item.downloadURL { url, error in
//                        if let url = url {
//                            DispatchQueue.main.async {
//                                // Avoid duplicates in the firebaseImages array
//                                if !firebaseImages.contains(url.absoluteString) {
//                                    firebaseImages.append(url.absoluteString)
//                                }
//                            }
//                        }
//                    }
//                }
//            } else {
//                print("No items found.")
//            }
//        }
//    }
//
//    // Upload car listing data
//    func uploadCarData(photoURLs: [String]) {
//        let db = Firestore.firestore()
//        let carData: [String: Any] = [
//            "model": model,
//            "manufacturer": manufacturer,
//            "vehicleType": vehicleType,
//            "carCondition": carCondition,
//            "year": year,
//            "engineType": engineType,
//            "photosURL": photoURLs,
//            "timestamp": Timestamp(date: Date())
//        ]
//
//        db.collection("cars").addDocument(data: carData) { error in
//            if let error = error {
//                print("Failed to upload car data: \(error.localizedDescription)")
//            } else {
//                print("Car data uploaded successfully!")
//            }
//        }
//    }
//}

struct ListCarView_Previews: PreviewProvider {
    static var previews: some View {
        ListCarView()
    }
}

extension Notification.Name {
    static let didUploadCar = Notification.Name("didUploadCar")
    static let didDeleteCar = Notification.Name("didDeleteCar")
}

