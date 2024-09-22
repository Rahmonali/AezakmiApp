//
//  FirebaseUserService.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

struct FirebaseUserService: UserServiceProtocol {
    func fetchCurrentUser() async throws -> User? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        let snapshot = try await FirestoreConstants.UserCollection.document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        return user
    }
}
