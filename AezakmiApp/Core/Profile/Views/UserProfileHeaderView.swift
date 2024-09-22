//
//  UserProfileHeaderView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import SwiftUI

struct UserProfileHeaderView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        VStack(spacing: 50) {
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(.white)
                    .frame(width: 300, height: 200)
                    .shadow(radius: 10)
                
                VStack(spacing: 16) {
                    CircularProfileImageView(imageUrl: nil, size: .xLarge)
                    
                    if let user = userViewModel.user {
                        VStack {
                            Text(user.fullname)
                                .font(.headline)
                            
                            Text(user.email)
                                .font(.footnote)
                        }
                    } else {
                        VStack {
                            Text("John Doe")
                                .font(.headline)
                                .redacted(reason: .placeholder)
                            
                            Text("johndoe@gmail.com")
                                .font(.footnote)
                                .redacted(reason: .placeholder)
                        }
                    }
                }
            }
            
            Button(action: {
                authManager.signOut()
            }, label: {
                Text("Log Out")
                    .modifier(PrimaryButtonModifier())
            })
            .padding(.vertical)
        }
        .task {
            await userViewModel.fetchCurrentUser()
        }
    }
}

#Preview {
    UserProfileHeaderView(authManager: AuthManager(service: MockAuthService()))
        .environmentObject(UserViewModel(service: MockUserService()))
}
