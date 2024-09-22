//
//  AuthManager.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import FirebaseAuth


class AuthManager: ObservableObject {
    @Published var authState: AuthState = .unauththicated
    
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.service = service
        loadCurrentUser()
    }
    
    private func loadCurrentUser() {
        DispatchQueue.main.async {
            if let currentUid = Auth.auth().currentUser?.uid {
                self.authState = .authenticated(uid: currentUid)
            }
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let uid = try await service.login(withEmail: email, password: password)
            self.authState = .authenticated(uid: uid)
        } catch {
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let uid = try await service.createUser(withEmail: email, password: password, fullname: fullname)
            self.authState = .authenticated(uid: uid)
        } catch {
            throw error
        }
    }
    
    @MainActor
    func signOut() {
        service.signout()
        self.authState = .unauththicated
    }
    
    @MainActor
    func sendPasswordResetEmail(email: String) async throws {
        do {
            try await service.sendPasswordResetEmail(toEmail: email)
        } catch {
            throw error
        }
    }
    
    @MainActor
    func googleSignIn() async throws {
        do {
            let uid = try await service.googleSignIn()
            if let id = uid {
                self.authState = .authenticated(uid: id)
            }
        } catch {
            throw error
        }
    }
}
