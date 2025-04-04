//
//  LoginViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-04-04.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    @MainActor
    func login() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter all fields"
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return
        }
        
        self.errorMessage = "" // Reset error message
        
        try await AuthManager.shared.login(email: email, password: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
