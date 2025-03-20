//
//  ImageCarousel.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-20.
//

import SwiftUI

struct ImageCarousel: View {
    
    let images: [String]
    
    var body: some View {
        TabView{
            ForEach(images, id: \.self){ image in
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(width: UIScreen.main.bounds.width - 10, height: 300)
        .cornerRadius(10)
                      
    }
}

#Preview {
    ImageCarousel(images: ["car1","car1","car1"])
}
