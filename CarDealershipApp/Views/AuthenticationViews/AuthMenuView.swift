//
//  AuthMenuView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-11.
//

import SwiftUI

struct AuthMenuView: View {
    var body: some View {
        NavigationView{
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
                
                NavigationLink(destination: SignUpView()) {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.black)
                        .frame(width: 300, height: 70)
                        .overlay(
                            HStack (alignment: .center){
                                Text("Sign Up")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }.padding()
                        )
                    .padding(.bottom, 50)
                }
                
                NavigationLink(destination: LoginView()) {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.black)
                        .frame(width: 300, height: 70)
                        .overlay(
                            HStack (alignment: .center){
                                Text("Login")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }.padding()
                        )
                }
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    AuthMenuView()
}
