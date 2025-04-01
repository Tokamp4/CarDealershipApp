//
//  ContentView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-11.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @State private var showAuthMenuView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationView{
                MainContainerView()
    
            }
        }
        .onAppear {
            Task {
                await vm.fetchSignedUser()
            }
        }
        .onChange(of: vm.user) { newValue in
            showAuthMenuView = newValue == nil
        }
        .fullScreenCover(isPresented: $showAuthMenuView) {
            NavigationView{
                AuthMenuView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
