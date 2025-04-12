//
//  ProfileView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject private var vm = ProfileViewModel()
    @State private var showLogoutAlert = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    
    let carImages = ["car1", "car1", "car1"]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    //profile (profile pic image for user to pick)
                    
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
                                }
                                else
                                {
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
                        
                        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
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
                    
                    //about section
                    VStack(alignment: .leading, spacing: 5) {
                        Text("About")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.all)
                    
                    //"your" cars section
                    //                    HStack {
                    //                        Text("Your Car’s")
                    //                            .font(.headline)
                    //                        Spacer()
                    //                        Button(action: {}) {
                    //                            HStack {
                    //                                Text("Filter")
                    //                                    .font(.subheadline)
                    //                                    .foregroundColor(.gray)
                    //                                Image(systemName: "line.horizontal.3.decrease.circle")
                    //                                    .foregroundColor(.gray)
                    //                            }
                    //                        }
                    //                    }
                    //                    .padding(.horizontal)
                    //
                    //                    ScrollView(.horizontal, showsIndicators: false) {
                    //                        HStack(spacing: 10) {
                    //                            ForEach(carImages, id: \.self) { image in
                    //                                ZStack(alignment: .topTrailing) {
                    //                                    Image(image)
                    //                                        .resizable()
                    //                                        .frame(width: 180, height: 100)
                    //                                        .cornerRadius(10)
                    //                                    Button(action: {}) {
                    //                                        Image(systemName: "checkmark.circle.fill")
                    //                                            .foregroundColor(.green)
                    //                                            .padding(5)
                    //                                    }
                    //                                }
                    //                            }
                    //                        }
                    //                        .padding(.all)
                    //                    }
                    HStack {
                        Text("Your Cars")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if vm.myCars.isEmpty {
                        Text("Your car listings will appear here when you have some.")
                            .foregroundColor(.gray)
                            .italic()
                            .padding(.horizontal)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(vm.myCars, id: \.id) { car in
                                    AsyncImage(url: URL(string: car.imageURL)) { image in
                                        image.resizable()
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
                    
                    
                    // recently view listings
                    //                    HStack {
                    //                        Text("Recently Viewed Listings")
                    //                            .font(.headline)
                    //                        Spacer()
                    //                        Button(action: {}) {
                    //                            HStack {
                    //                                Text("Filter")
                    //                                    .font(.subheadline)
                    //                                    .foregroundColor(.gray)
                    //                                Image(systemName: "line.horizontal.3.decrease.circle")
                    //                                    .foregroundColor(.gray)
                    //                            }
                    //                        }
                    //                    }
                    //                    .padding(.horizontal)
                    //
                    //                    ScrollView(.horizontal, showsIndicators: false) {
                    //                        HStack(spacing: 10) {
                    //                            ForEach(carImages, id: \.self) { image in
                    //                                Image(image)
                    //                                    .resizable()
                    //                                    .frame(width: 180, height: 100)
                    //                                    .cornerRadius(10)
                    //                            }
                    //                        }
                    //                        .padding(.horizontal)
                    //                    }
                    HStack {
                        Text("Recently Viewed Listings")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if vm.recentlyViewed.isEmpty {
                        Text("The listings you view will appear here!")
                            .foregroundColor(.gray)
                            .italic()
                            .padding(.horizontal)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(vm.recentlyViewed, id: \.id) { car in
                                    AsyncImage(url: URL(string: car.imageURL)) { image in
                                        image.resizable()
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
    }
}
