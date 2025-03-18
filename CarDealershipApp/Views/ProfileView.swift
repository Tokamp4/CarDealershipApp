//
//  ProfileView.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-03-17.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userName: String = "Adril"
    @Published var reservations: [String] = ["Toyota Corolla - Test Drive", "Ford Mustang - Test Drive"]
    
    func signOut() {
        print("User signed out")
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(viewModel.userName)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                List(viewModel.reservations, id: \.self) { reservation in
                    Text(reservation)
                }
                .frame(height: 200)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Sign Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
