//
//  CustomButton.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-14.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button{
            action()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.black)
                .frame(width: 300, height: 70)
                .overlay(
                    HStack (alignment: .center){
                        Text(title)
                            .font(.title)
                            .foregroundColor(.white)
                    }.padding()
                )
        }
    }
}

#Preview {
    CustomButton(title: "hello", action: {print("button tapped")})
}
