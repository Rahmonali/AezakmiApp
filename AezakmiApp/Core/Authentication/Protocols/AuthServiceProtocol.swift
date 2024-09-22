//
//  AuthServiceProtocol.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import Foundation

protocol AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String
    func createUser(withEmail email: String, password: String, fullname: String) async throws -> String
    func sendPasswordResetEmail(toEmail email: String) async throws
    func signout()
    func googleSignIn() async throws -> String?
}
