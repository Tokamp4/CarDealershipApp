//
//  LogoutButton.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-13.
//

import SwiftUI

struct LogoutButton: View {
    @Binding var showLogoutAlert: Bool
    var onLogout: () -> Void

    var body: some View {
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
                    onLogout()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

