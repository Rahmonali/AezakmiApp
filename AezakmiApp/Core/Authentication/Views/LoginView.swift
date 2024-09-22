//
//  LoginView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 20/09/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        self._viewModel = StateObject(wrappedValue: LoginViewModel(authManager: authManager))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                textFields
                forgotPasswordView
                loginButton
                Spacer()
                Divider()
                signUpNavigateButton
            }
            .alert("Error", isPresented: $viewModel.showError, actions: {
                Button("Ok") {
                    viewModel.errorMessage = nil
                    viewModel.showError = false
                }
            }, message: {
                if let message = viewModel.errorMessage {
                    Text("Invalid login credential\n" + message)
                }
            })
        }
    }
}

extension LoginView {
    
    private var textFields: some View {
        VStack {
            TextField("Enter your email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .modifier(PrimaryTextFieldModifier())
            
            SecureField("Enter your password", text: $viewModel.password)
                .modifier(PrimaryTextFieldModifier())
        }
    }
    
    private var loginButton: some View {
        VStack (spacing: 20) {
            Button(action: {
                Task { await viewModel.login() }
            }, label: {
                Text(viewModel.isLoading ? "" : "Login")
                    .modifier(PrimaryButtonModifier())
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(Color.white)
                        }
                    }
            })
            .padding(.vertical)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.7)
            
            GoogleSignInButton(scheme: .light, style: .standard, state: .normal) {
                Task { await viewModel.googleSignIn() }
            }
            .frame(width: 360)
            .overlay(alignment: .trailing) {
                if viewModel.isLoadingGSingIn {
                    ProgressView()
                        .tint(Color.pink)
                        .padding(.trailing, 30)
                }
            }
        }
    }
    
    private var forgotPasswordView: some View {
        NavigationLink {
            ForgotPasswordView(viewModel: viewModel)
        } label: {
            Text("Forgot Password?")
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.top)
                .padding(.trailing, 28)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var signUpNavigateButton: some View {
        NavigationLink {
            RegistrationView(authManager: authManager)
                .navigationBarBackButtonHidden()
        } label: {
            HStack(spacing: 2) {
                Text("Don't have an acount?")
                
                Text("Sign Up")
                    .fontWeight(.semibold)
                
            }
            .font(.footnote)
        }
        .padding(.vertical)
    }
}

// MARK: - AuthenticationFormProtocol
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return viewModel.isValidLogin()
    }
}

#Preview {
    LoginView(authManager: AuthManager(service: MockAuthService()))
}
