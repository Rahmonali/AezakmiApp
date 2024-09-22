//
//  LoginViewModel.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading: Bool = false
    @Published var isLoadingGSingIn: Bool = false
    @Published var showError: Bool = false
    @Published var didSendEmail: Bool = false
    @Published var errorMessage: String?
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    @MainActor
    func login() async {
        isLoading.toggle()
        defer { isLoading.toggle() }
        do {
            try await authManager.login(withEmail: email, password: password)
        } catch {
            print("Failed to login with error: \(error.localizedDescription)")
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func sendResetPasswordLink(toEmail: String) async throws {
        try await authManager.sendPasswordResetEmail(email: email)
    }
    
    @MainActor
    func googleSignIn() async {
        isLoadingGSingIn.toggle()
        
        defer { isLoadingGSingIn.toggle() }
        do {
            try await authManager.googleSignIn()
        } catch {
            print("Failed to google sign in with error: \(error.localizedDescription)")
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    }
}

extension LoginViewModel {
    func isValidLogin() -> Bool {
        return email.isValidEmail() &&
        !password.isEmpty &&
        password.count > 5 &&
        password.count < 15
    }
}
