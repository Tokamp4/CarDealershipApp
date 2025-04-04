//
//  ProfileViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    func signOut(){
        AuthService.shared.signOut()
        UserService.shared.reset()
    }
    
}
