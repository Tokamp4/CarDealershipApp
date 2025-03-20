//
//  ExConfirmationView.swift
//  CarDealershipApp
//
//  Created by Nizmee Wuvais on 2025-03-20.
//

import SwiftUI

struct ExConfirmationView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .padding()
            
            Text("Exchange Confirmed")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your car exchange has been successfully processed.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button(action: {}) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

#Preview {
    ExConfirmationView()
}
