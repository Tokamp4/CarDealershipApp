//
//  SignUpView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-14.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var vm = SignUpViewModel()
    
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
            TextField("Name", text: $vm.name)
                .modifier(RoundedTextFieldStyle())
                .padding()
            TextField("User Name", text: $vm.username)
                .modifier(RoundedTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            TextField("Email", text: $vm.email)
                .modifier(RoundedTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
            SecureField("Password", text: $vm.password)
                .modifier(RoundedTextFieldStyle())
                .padding()
            Text(vm.errorMessage)
                .foregroundStyle(Color.red)
            Spacer()
            CustomButton(title: "Create Account", action: {
                Task{
                    try await vm.signUp()
                }
            })
            Spacer()
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(SignUpViewModel())
}
