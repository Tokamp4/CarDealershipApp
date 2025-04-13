import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ListCarView: View {
    @State private var imageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    @State private var model: String = ""
    @State private var manufacturer: String = ""
    @State private var vehicleType: String = ""
    @State private var carCondition: String = ""
    @State private var year: String = ""
    @State private var engineType: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("New Vehicle Listing")
                    .font(.title)
                    .padding(.horizontal)
                
                // Photo Picker
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    VStack {
                        if let imageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                        Text("Add photos/videos")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            imageData = data
                        }
                    }
                }

                // Text Fields
                Group {
                    TextField("Model", text: $model)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Manufacturer", text: $manufacturer)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Vehicle Type", text: $vehicleType)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Car Condition", text: $carCondition)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Year", text: $year)
                        .modifier(RoundedTextFieldStyle())
                    TextField("Engine", text: $engineType)
                        .modifier(RoundedTextFieldStyle())
                }
                .padding(3)

                // Upload Button
                Button(action: {
                    uploadPhoto { result in
                        switch result {
                        case .success(let url):
                            uploadCarData(photoURL: url)
                        case .failure(let error):
                            print("Photo upload failed: \(error.localizedDescription)")
                        }
                    }
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
            }
            .padding()
        }
    }

    // Upload image to Firebase Storage
    func uploadPhoto(completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = imageData else {
            completion(.failure(NSError(domain: "No image selected", code: 0)))
            return
        }

        let storageRef = Storage.storage().reference().child("car_images/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let downloadURL = url?.absoluteString {
                    completion(.success(downloadURL))
                }
            }
        }
    }

    // Upload car details + image URL to Firestore
    func uploadCarData(photoURL: String) {
        let db = Firestore.firestore()
        let carData: [String: Any] = [
            "model": model,
            "manufacturer": manufacturer,
            "vehicleType": vehicleType,
            "carCondition": carCondition,
            "year": year,
            "engineType": engineType,
            "photoURL": photoURL,
            "timestamp": Timestamp(date: Date())
        ]

        db.collection("cars").addDocument(data: carData) { error in
            if let error = error {
                print("Failed to upload car data: \(error.localizedDescription)")
            } else {
                print("Car data uploaded successfully!")
            }
        }
    }
}


// Preview
struct ListCarView_Previews: PreviewProvider {
    static var previews: some View {
        ListCarView()
    }
}
