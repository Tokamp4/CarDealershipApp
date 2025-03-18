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
            ZStack{
                Image("bgAuth")
                    .resizable()
                    
                    .frame(maxWidth: .infinity, maxHeight: 200) // Corrected .frame for dynamic width
                    .edgesIgnoringSafeArea(.top)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                Text("Get Started")
                    .font(.system(size: 60, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .frame(width: 210)
                    .padding(.top, 140)
                    .padding(.trailing, 80)
            }.edgesIgnoringSafeArea(.top)
            Spacer()
         
            Text("Don't have an account yet?")
                .font(.system(size: 25, weight: .regular, design: .default))
                
            
            CustomButton(title: "Sign Up", action: {
                //signup func
            })
            .padding(.bottom, 50)
            
            CustomButton(title: "Login", action: {
                //login func
            })
            Spacer()
        }
        
    }
}

#Preview {
    AuthMenuView()
}
