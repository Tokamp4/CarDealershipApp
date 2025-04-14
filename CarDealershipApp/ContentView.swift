//
//  ContentView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-11.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        Group{
            if vm.userSession != nil {
                MainContainerView()
                    .id(UserService.shared.currentUser)
            } else {
                NavigationView {
                    AuthMenuView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
