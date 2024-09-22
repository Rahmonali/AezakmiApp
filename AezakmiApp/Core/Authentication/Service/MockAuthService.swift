//
//  MockAuthService.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import Foundation

struct MockAuthService: AuthServiceProtocol {
    
    func login(withEmail email: String, password: String) async throws -> String {
        return NSUUID().uuidString
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws -> String {
        return NSUUID().uuidString
    }
    
    func fetchCurrentUser() async throws -> User? {
        return User(fullname: "John Doe", email: "johndoe@gmail.com", id: NSUUID().uuidString)
    }
    
    func sendPasswordResetEmail(toEmail email: String) async throws {
        print("Sent a link to the email")
    }
    
    func signout() { }
    
    func googleSignIn() async throws -> String?  {
        return NSUUID().uuidString
    }
}
