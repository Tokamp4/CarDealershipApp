//
//  ListingsView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-17.
//

import SwiftUI

struct ListingsView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Marketplace")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .padding(.horizontal)
                Spacer()
                
            }
            HStack(spacing: 30){
                Button{
                    // sell page navigation
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: 160, height: 30)
                        .overlay{
                            HStack{
                                Image(systemName: "tag.fill")
                                    .foregroundColor(.white)
                                Text("Sell")
                                    .foregroundColor(.white)
                            }
                            
                        }
                }
                Button{
                    // sell page navigation
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: 160, height: 30)
                        .overlay{
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)
                                Text("Search")
                                    .foregroundColor(.white)
                            }
                            
                        }
                }
            }
           
                
            Spacer()
    
        }
    }
}

#Preview {
    ListingsView()
}
