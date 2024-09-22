//
//  MockUserService.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import Foundation

struct MockUserService: UserServiceProtocol {
    func fetchCurrentUser() async throws -> User? {
        return User(fullname: "John Doe", email: "johndoe@gmail.com", id: NSUUID().uuidString)
    }    
}
