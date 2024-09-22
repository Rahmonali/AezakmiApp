//
//  ContentView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authManager: AuthManager    
    @State private var showAlert = false
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    var body: some View {
        VStack {
            switch authManager.authState {
                case .unauththicated:
                    LoginView(authManager: authManager)
                case .authenticated:
                    CustomTabView(authManager: authManager)
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView(authManager: AuthManager(service: MockAuthService()))
}
