import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject private var vm = ProfileViewModel()
    @State private var showLogoutAlert = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Profile Section
                    VStack {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        } else if let urlString = vm.profileImageUrl, let url = URL(string: urlString) {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                } else if phase.error != nil {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .foregroundColor(.gray)
                                } else {
                                    ProgressView()
                                }
                            }
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                        
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Text("Change Profile Picture")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                        .onChange(of: selectedItem) {
                            Task {
                                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    self.profileImage = uiImage
                                    vm.uploadProfileImage(image: uiImage)
                                }
                            }
                        }
                        
                        Text("Main Account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Adril")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    
                    // About Section
                    VStack(alignment: .leading, spacing: 5) {
                        Text("About")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    // User's Cars Section
                    VStack(alignment: .leading) {
                        Text("Your Cars")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if vm.myCars.isEmpty {
                            Text("Your car listings will appear here when you have some.")
                                .foregroundColor(.gray)
                                .italic()
                                .padding(.horizontal)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(vm.myCars) { car in
                                        NavigationLink(destination: CarDetailsView(car: car)) {
                                            AsyncImage(url: URL(string: car.imageURL)) { image in
                                                image.resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                Color.gray
                                            }
                                            .frame(width: 180, height: 100)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Recently Viewed Listings Section
                    VStack(alignment: .leading) {
                        Text("Recently Viewed Listings")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if vm.recentlyViewed.isEmpty {
                            Text("The listings you view will appear here!")
                                .foregroundColor(.gray)
                                .italic()
                                .padding(.horizontal)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(vm.recentlyViewed) { car in
                                        AsyncImage(url: URL(string: car.imageURL)) { image in
                                            image.resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 180, height: 100)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Logout Button
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("Do you really want to log out?"),
                            primaryButton: .destructive(Text("Log Out")) {
                                vm.signOut()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            vm.fetchMyCars()
        }
    }
}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCar = CarModel(
            id: "1",
            imageURL: "https://images.unsplash.com/photo-1549921296-3a5f1c6b4408",
            model: "Civic",
            manufacturer: "Honda",
            price: "15000",
            year: "2020",
            engineType: "Petrol",
            condition: "Used",
            userId: "user1"
        )
        
        let mockVM = ProfileViewModel()
        mockVM.myCars = [mockCar, mockCar]
        mockVM.recentlyViewed = [mockCar]
        mockVM.profileImageUrl = "https://images.unsplash.com/photo-1607746882042-944635dfe10e"
        
        return ProfileView()
            .environmentObject(mockVM)
            .previewDevice("iPhone 14")
    }
}
