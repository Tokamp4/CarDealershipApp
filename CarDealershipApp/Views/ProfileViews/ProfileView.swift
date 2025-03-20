//
//  ProfileView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI

struct ProfileView: View {
    let carImages = ["car1", "car1", "car1"]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    //profile info
                    VStack {
                        Image(systemName: "profileImage")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                            .overlay(Image(systemName: "profileImage").offset(x: 15, y: -15))
                        
                        Text("Main Account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Adril")
                            .font(.subheadline)
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
                    .padding()
                    
                    //"your" cars section
                    HStack {
                        Text("Your Car’s")
                            .font(.headline)
                        Spacer()
                        Button(action: {}) {
                            HStack {
                                Text("Filter")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(carImages, id: \..self) { image in
                                Image(image)
                                    .resizable()
                                    .frame(width: 120, height: 80)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // recently view listings
                    HStack {
                        Text("Recently Viewed Listings")
                            .font(.headline)
                        Spacer()
                        Button(action: {}) {
                            HStack {
                                Text("Filter")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(carImages, id: \..self) { image in
                                Image(image)
                                    .resizable()
                                    .frame(width: 120, height: 80)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            //bottom nav page
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "cart")
                    Text("Listings")
                }
                Spacer()
                VStack {
                    Image(systemName: "star")
                    Text("Program")
                }
                Spacer()
                VStack {
                    Image(systemName: "bubble.left")
                    Text("Chats")
                }
                Spacer()
                VStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(20)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
