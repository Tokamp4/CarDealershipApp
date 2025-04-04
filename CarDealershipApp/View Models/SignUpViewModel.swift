//
//  AuthViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-03-27.
//

import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    
    func signUp() async throws {
        guard !name.isEmpty, !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter all fields"
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return
        }

        self.errorMessage = "" // Reset error message

        try await AuthService.shared.createUser(name: name, username: username, email: email, password: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
