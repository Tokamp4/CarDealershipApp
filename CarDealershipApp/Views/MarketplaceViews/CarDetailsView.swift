import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct CarDetailsView: View {
    let car: CarModel
    @State private var seller: UserModel?
    @State private var conversation: ConversationModel?
    @State private var navigateToChat = false
    @State private var isLoadingConversation = false
    @State private var imageURLs: [String] = [] // Store URLs for images

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Display the image from Firebase Storage using AsyncImage
                if !imageURLs.isEmpty {
                    TabView {
                        ForEach(imageURLs, id: \.self) { imageURL in
                            AsyncImage(url: URL(string: imageURL)) { image in
                                image.resizable()
                                     .scaledToFill()
                                     .frame(height: 250)
                                     .clipped() // Ensures image is clipped to fit the frame
                            } placeholder: {
                                ProgressView() // Loading indicator while image is being fetched
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 250) // Adjust the height of the image carousel
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("\(car.manufacturer) \(car.model)")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Price: \(car.price)")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Year: \(car.year)")
                    Text("Condition: \(car.condition)")
                    Text("Engine: \(car.engineType)")
                }
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.horizontal)

                Divider()
                    .padding(.horizontal)

                if let seller = seller {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Seller")
                            .font(.title3)
                            .fontWeight(.semibold)

                        HStack(spacing: 12) {
                            Image("profileImage") // Replace with dynamic profile image if needed
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)

                            VStack(alignment: .leading) {
                                Text(seller.name)
                                    .font(.headline)
                                Text(seller.email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Button(action: {
                                Task {
                                    await prepareConversation(with: seller)
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .frame(width: 130, height: 36)
                                    .overlay(
                                        HStack {
                                            if isLoadingConversation {
                                                ProgressView()
                                                    .scaleEffect(0.6)
                                            } else {
                                                Image(systemName: "message")
                                                Text("Message")
                                            }
                                        }
                                        .foregroundColor(.white)
                                    )
                            }
                            .disabled(isLoadingConversation)
                        }

                        NavigationLink(
                            destination: Group {
                                if let convo = conversation {
                                    // Navigate to ConversationView if conversation exists
                                    ConversationView(
                                        convo: convo,
                                        currentUser: UserModel(
                                            id: Auth.auth().currentUser?.uid ?? "",
                                            name: "Current User",
                                            username: "currentuser",
                                            email: "current@email.com"
                                        ),
                                        isPreview: false
                                    )
                                } else {
                                    EmptyView() // Show empty view if no conversation exists
                                }
                            },
                            isActive: $navigateToChat
                        ) {
                            EmptyView() // Hides the NavigationLink's visual content
                        }
                        .hidden()
                    }
                    .padding(.horizontal)
                } else {
                    ProgressView("Loading seller...")
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top)
        }
        .onAppear {
            fetchSeller()
            fetchCarImages() // Fetch images from Firebase Storage
        }
    }

    private func fetchSeller() {
        let db = Firestore.firestore()
        db.collection("users").document(car.userId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found for user")
                return
            }
            
            if let id = snapshot?.documentID,
               let name = data["name"] as? String,
               let username = data["username"] as? String,
               let email = data["email"] as? String {
                DispatchQueue.main.async {
                    seller = UserModel(id: id, name: name, username: username, email: email)
                }
            } else {
                print("User data is incomplete.")
            }
        }
    }

    // Fetch car images from Firebase Storage (we use the provided Firebase URL directly)
    private func fetchCarImages() {
        // Add the provided image URL to the imageURLs array
        let carImageURL = "https://firebasestorage.googleapis.com/v0/b/cardealershipapp-eaf6e.firebasestorage.app/o/car_images%2Ftesla.jpg?alt=media&token=66f63cc9-b1bd-4d35-aad5-b0430373ade5"
        
        // Add the URL to the imageURLs array to display it
        imageURLs.append(carImageURL)
    }

    private func prepareConversation(with seller: UserModel) async {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        isLoadingConversation = true

        let db = Firestore.firestore()
        let conversationsRef = db.collection("conversations")

        let participants = [seller.id, currentUserId].sorted()
        let query = conversationsRef.whereField("participants", isEqualTo: participants)

        do {
            let snapshot = try await query.getDocuments()
            if let existingDoc = snapshot.documents.first {
                let data = existingDoc.data()
                let convo = ConversationModel(
                    id: existingDoc.documentID,
                    participants: participants,
                    lastMessage: data["lastMessage"] as? String ?? "",
                    lastTimestamp: (data["lastTimestamp"] as? Timestamp)?.dateValue() ?? Date()
                )
                self.conversation = convo
                self.navigateToChat = true
            } else {
                let newConvoRef = conversationsRef.document()
                let newConvoData: [String: Any] = [
                    "participants": participants,
                    "lastMessage": "Started a conversation",
                    "lastTimestamp": FieldValue.serverTimestamp()
                ]
                try await newConvoRef.setData(newConvoData)

                let convo = ConversationModel(
                    id: newConvoRef.documentID,
                    participants: participants,
                    lastMessage: "Started a conversation",
                    lastTimestamp: Date()
                )
                self.conversation = convo
                self.navigateToChat = true
            }
        } catch {
            print("Error preparing conversation: \(error.localizedDescription)")
        }

        isLoadingConversation = false
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        CarDetailsView(car: CarModel(
            photosURL: ["https://firebasestorage.googleapis.com/v0/b/cardealershipapp-eaf6e.firebasestorage.app/o/car_images%2Ftesla.jpg?alt=media&token=66f63cc9-b1bd-4d35-aad5-b0430373ade5"],
            model: "Model S",
            manufacturer: "Tesla",
            price: "$750,000",
            vehicleType: "",
            year: "2022",
            engineType: "Electric",
            condition: "New",
            userId: "test"
        ))
    }
}
