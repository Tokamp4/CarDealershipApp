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
                .frame(maxWidth: .infinity, maxHeight: 150) // Corrected .frame for dynamic width
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
                .overlay(
                    Text("Get Started")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .frame(width: 140)
                        .padding(.top, 40)
                        .padding(.leading, 40),
                    alignment: .bottomLeading // Correct alignment syntax
                )

                    
            Spacer()
         
            Text("Don't have an account yet?")
                .font(.system(size: 25, weight: .regular, design: .default))
                
            
            Button{
                //sign up function
            } label: {
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
            }.padding(.bottom, 50)
            
            Button{
                //sign up function
            } label: {
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

#Preview {
    AuthMenuView()
}
