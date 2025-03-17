//
//  SignUpView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-14.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Image("bgAuth")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .edgesIgnoringSafeArea(.top)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                VStack(alignment: .leading) {
                    Text("Log in")
                        .font(.system(size: 65, design: .default))
                        .foregroundColor(.black)
                        .padding(.trailing, 150)
                }
                .padding(.top, 175)
            }
            .edgesIgnoringSafeArea(.top)
            Spacer()
            TextField("User Name", text: $username)
                .modifier(RoundedTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .frame(height: 100)
                .font(.system(size: 24))

            TextField("Password", text: $password)
                .modifier(RoundedTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .frame(height: 80)
                .font(.system(size: 24))
            Spacer()
            HStack {
                Text("forgot password?")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.black)
                Text("click here")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.yellow)
                    .underline()
            }
            .padding()
            CustomButton(title: "Login", action: {
                // Create account function
            })
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
