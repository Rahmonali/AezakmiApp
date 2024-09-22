//
//  CustomTabView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab = 0
    @ObservedObject var authManager: AuthManager
    
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
                .environmentObject(homeVM)
            
            UserProfileHeaderView(authManager: authManager)
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
        }
        .tint(Color(.systemPink))
    }
}

#Preview {
    CustomTabView(authManager: AuthManager(service: MockAuthService()))
}
