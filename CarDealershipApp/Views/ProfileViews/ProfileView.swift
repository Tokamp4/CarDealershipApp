import SwiftUI
import PhotosUI

struct ProfileView: View {

    @StateObject private var vm = ProfileViewModel()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        // Profile Section
                        
                        ProfileHeaderSection(
                            profileImage: profileImage,
                            urlString: vm.profileImageUrl,
                            selectedItem: $selectedItem,
                            displayName: vm.displayName ?? "",
                            onUpload: { image in
                                self.profileImage = image
                                vm.uploadProfileImage(image: image)
                            }
                        )
                        .padding(.top, 30)
                        .padding(.horizontal)

                        // About Section
                        
                        AboutSection(bio: vm.bio ?? "") { newBio in
                            vm.updateBio(newBio: newBio)
                        }

                            .padding(.horizontal)

                        // Your Cars Section
                        
                        UserCarsSection(cars: vm.myCars)
                            .padding(.horizontal)

                        // Recently Viewed Section
                        
                        RecentlyViewedSection(cars: vm.recentlyViewed)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 100)
                }

                
                HStack {
                    Spacer()
                    LogoutButton(showLogoutAlert: $showLogoutAlert) {
                        vm.signOut()
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
