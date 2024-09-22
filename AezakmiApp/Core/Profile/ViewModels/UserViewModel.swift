//
//  UserViewModel.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    
    private let service: UserServiceProtocol
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func fetchCurrentUser() async {
        isLoading.toggle()
        defer { isLoading.toggle() }
        do {
            self.user = try await service.fetchCurrentUser()            
        } catch {
            print("Failed to fetch user with error: \(error.localizedDescription)")
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    }
}
