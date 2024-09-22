//
//  UserServiceProtocol.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import Foundation


protocol UserServiceProtocol {
    func fetchCurrentUser() async throws -> User?
}
