//
//  MainContainerView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-20.
//

import SwiftUI

struct MainContainerView: View {
    var body: some View {
        TabView {
            ListingsView()
                .tabItem {
                    Label("Listings", systemImage: "car.fill")
                }
            ExchangeView()
                .tabItem {
                    Label("Program", systemImage: "star.fill")
                }
            ContactsView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    MainContainerView()
}
