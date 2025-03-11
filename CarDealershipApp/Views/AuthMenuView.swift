//
//  AuthMenuView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-11.
//

import SwiftUI

struct AuthMenuView: View {
    var body: some View {
        VStack{
            Image("bgAuth")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .frame(width: .infinity, height: 150)
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
                .overlay{
                    
                }
                    
                    
            Spacer()
            Button{
                
            } label: {
                Text("Login")
            }
        }
        
    }
}

#Preview {
    AuthMenuView()
}
