//
//  RegistrationViewModel.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    @MainActor
    func createUser() async {
        isLoading.toggle()
        defer { isLoading.toggle() }
        do {
            try await authManager.createUser(withEmail: email, password: password, fullname: fullname)
        } catch {
            print("Failed to create user with error: \(error.localizedDescription)")
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    }
}

extension RegistrationViewModel {
    func isValidRegistration() -> Bool {
        return email.isValidEmail() &&
        fullname.count > 5 &&
        !fullname.isEmpty &&
        !password.isEmpty &&
        password.count > 5 &&
        password.count < 15
    }
}
