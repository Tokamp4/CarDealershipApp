//
//  ProfileView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var vm: SignUpViewModel
    
    let carImages = ["car1", "car1", "car1"]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    //profile info
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .overlay(Image(systemName: "profileImage").offset(x: 15, y: -15))
                        
                        Text("Main Account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Adril")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    Spacer()
                    
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
                                ZStack(alignment: .topTrailing){
                                    Image(image)
                                        .resizable()
                                        .frame(width: 180, height: 100)
                                        .cornerRadius(10)
                                    Button(action: {
                                        //we make the checkmark a toggle so we can switch from it being an x or a checkmark
                                    }) {
                                        Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .padding(5)
                                }
                                }
                            }
                        }
                        .padding(.all)
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
                                    .frame(width: 180, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            CustomButton(title: "Log Out") {
//                do{
//                    //try vm.signOut()
//                }
//                catch{
//                    print(error.localizedDescription)
//                }
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SignUpViewModel())
    }
}
