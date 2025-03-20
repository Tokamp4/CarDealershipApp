//
//  ChatHeaderView.swift
//  CarDealershipApp
//
//  Created by Henrique on 2025-03-19.
//

import SwiftUI

struct ConversationHeaderView: View {
    
    var appUser: String
    var username: String
    
    var body: some View {
        VStack{
            Image("profileImage")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90, alignment: .leading)
            Text(appUser)
                .font(.title.bold())
            Text(username)
        }
    }
}

#Preview {
    ConversationHeaderView(appUser: "App User", username: "username")
}
