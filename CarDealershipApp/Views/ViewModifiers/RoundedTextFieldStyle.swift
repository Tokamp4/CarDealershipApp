//
//  RoundedTextFieldStyle.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-14.
//

import SwiftUI

struct RoundedTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 20)
        }
}

#Preview {
    
}
