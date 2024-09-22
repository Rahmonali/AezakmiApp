//
//  AezakmiApp.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct AezakmiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userViewModel = UserViewModel(service: FirebaseUserService())
    
    let authManager = AuthManager(service: FirebaseAuthService())
    
    var body: some Scene {
        WindowGroup {
            ContentView(authManager: authManager)
                .environmentObject(userViewModel)
        }
    }
}
