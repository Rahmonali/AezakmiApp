//
//  RegistrationView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: RegistrationViewModel
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        self._viewModel = StateObject(wrappedValue: RegistrationViewModel(authManager: authManager))
    }
    
    var body: some View {
        VStack {
            Spacer()
            textFields
            createAccountButton
            Spacer()
            Divider()
            signInNavigateButton
        }
        .alert("Error", isPresented: $viewModel.showError, actions: {
            Button("Ok") {
                viewModel.errorMessage = nil
                viewModel.showError = false
            }
        }, message: {
            if let message = viewModel.errorMessage {
                Text(message)
            }
        })
    }
}

extension RegistrationView {
    private var textFields: some View {
        VStack {
            TextField("Enter your email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .modifier(PrimaryTextFieldModifier())
            
            SecureField("Enter your password", text: $viewModel.password)
                .modifier(PrimaryTextFieldModifier())
            
            TextField("Enter your full name", text: $viewModel.fullname)
                .modifier(PrimaryTextFieldModifier())
        }
    }
    
    private var createAccountButton: some View {
        Button(action: {
            Task { await viewModel.createUser() }
        }, label: {
            Text(viewModel.isLoading ? "" : "Create account")
                .modifier(PrimaryButtonModifier())
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.white)
                    }
                }
        })
        .disabled(!formIsValid)
        .opacity(formIsValid ? 1.0 : 0.7)
        .padding(.vertical)
    }
    
    private var signInNavigateButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            HStack(spacing: 2) {
                Text("Already have an account?")
                
                Text("Sign In")
                    .fontWeight(.semibold)
                
            }
            .font(.footnote)
        })
        .padding(.vertical)
    }
}

// MARK: - AuthenticationFormProtocol
extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return viewModel.isValidRegistration()
    }
}


#Preview {
    RegistrationView(authManager: AuthManager(service: MockAuthService()))
}
