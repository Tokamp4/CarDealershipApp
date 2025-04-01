//
//  AuthViewModel.swift
//  CarDealershipApp
//
//  Created by Eduardo on 2025-03-27.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var user: UserModel?

    
    func signUp() {
        guard !name.isEmpty, !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter all fields"
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return
        }

        self.errorMessage = "" // Reset error message
        self.user = nil // Reset user while signing up

        Task {
            do {
                let user = try await AuthenticationManager.shared.createUser(name: name, username: username, email: email, password: password)
                await MainActor.run {
                    self.user = user
                    self.errorMessage = "Success"
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func fetchSignedUser() async {
        Task {
            do {
                let user = try await AuthenticationManager.shared.getAuthenticatedUser()
                await MainActor.run { self.user = user }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func signOut() throws {
        do{
            try AuthenticationManager.shared.signOut()
            self.user = nil
        } catch {
            print("error")
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
