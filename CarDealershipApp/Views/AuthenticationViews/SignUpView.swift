//
//  SignUpView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-14.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack{
            ZStack{
                Image("bgAuth")
                    .resizable()
                    
                    .frame(maxWidth: .infinity, maxHeight: 200) // Corrected .frame for dynamic width
                    .edgesIgnoringSafeArea(.top)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                VStack(alignment: .leading){
                    Text("Create a new")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.trailing, 50)
                    Text("account")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        
                        
                }.padding(.top, 175)
               
                    
                    
            }.edgesIgnoringSafeArea(.top)
            Spacer()
            TextField("User Name", text: $username)
                .modifier(RoundedTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .modifier(RoundedTextFieldStyle())
                .padding()
            TextField("Password", text: $password)
                .modifier(RoundedTextFieldStyle())
                .padding()
            Spacer()
            CustomButton(title: "Create Account", action: {})
            Spacer()
        }
        
    }
}

#Preview {
    SignUpView()
}
