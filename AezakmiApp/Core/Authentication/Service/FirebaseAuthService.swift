//
//  FirebaseAuthService.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn

struct FirebaseAuthService: AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return result.user.uid
        } catch {
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws -> String {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            return result.user.uid
        } catch {
            throw error
        }
    }
    
    func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(fullname: fullname, email: email, id: id)
        guard let ecodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await FirestoreConstants.UserCollection.document(id).setData(ecodedUser)
    }
    
    func signout() {
        try? Auth.auth().signOut()
    }
    
    func sendPasswordResetEmail(toEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }
    
    @MainActor
    func googleSignIn() async throws -> String?  {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return nil
        }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        guard let idToken = result.user.idToken?.tokenString else { return nil }
        let accessToken = result.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        let uid = try await Auth.auth().signIn(with: credential)
        
        guard let name = result.user.profile?.name else { return "" }
        guard let email = result.user.profile?.email else { return "" }
        
        try await uploadUserData(email: email, fullname: "\(name)", id: uid.user.uid)
        
        return uid.user.uid
    }
    
}
