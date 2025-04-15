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
    @State private var imageURLs: [String] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if !imageURLs.isEmpty {
                    TabView {
                        ForEach(imageURLs, id: \.self) { imageURL in
                            AsyncImage(url: URL(string: imageURL)) { image in
                                image.resizable()
                                     .scaledToFill()
                                     .frame(height: 200)
                                     .clipped()
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 200)
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
                            Image("profileImage")
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
                                    EmptyView()
                                }
                            },
                            isActive: $navigateToChat
                        ) {
                            EmptyView()
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
            if let carId = car.id {
                RecentlyViewedService.addToRecentlyViewed(carId: carId)
            }
            fetchSeller()
            fetchCarImages()
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

    private func fetchCarImages() {
        let carImageURL = "https://firebasestorage.googleapis.com/v0/b/cardealershipapp-eaf6e.firebasestorage.app/o/car_images%2Fcivic.jpg?alt=media&token=17791f5f-1a35-473f-b9a3-74a8b54e9802"
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
            photosURL: ["https://firebasestorage.googleapis.com/v0/b/cardealershipapp-eaf6e.firebasestorage.app/o/car_images%2Fcivic.jpg?alt=media&token=17791f5f-1a35-473f-b9a3-74a8b54e9802"],
            model: "Model S",
            manufacturer: "Tesla",
            price: "$750,000",
            vehicleType: "Sedan",
            year: "2022",
            engineType: "Electric",
            condition: "New",
            userId: "test"
        ))
    }
}
