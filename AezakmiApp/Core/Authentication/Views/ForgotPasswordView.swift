//
//  ForgotPasswordView.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    @State private var isEmailSent: Bool = false
    
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            emailTextField
            resetPasswordButton
            Spacer()
            Divider()
            returnToLoginButton
        }
        .alert("Check your inbox", isPresented: $isEmailSent) {
            Button("OK") {
                onSendPasswordResetTap()
            }
        }
    }
}

private extension ForgotPasswordView {
    private var emailTextField: some View {
        TextField("Enter your email", text: $email)
            .keyboardType(.emailAddress)
            .modifier(PrimaryTextFieldModifier())
    }
    
    private var resetPasswordButton: some View {
        Button(action: {
            isEmailSent.toggle()
        }, label: {
            Text(viewModel.isLoading ? "" : "Reset Password")
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
    }
    
    private var returnToLoginButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Return to login")
                .font(.footnote)
        }
        .padding(.vertical, 16)
    }
}

private extension ForgotPasswordView {
    func onSendPasswordResetTap() {
        Task { try await viewModel.sendResetPasswordLink(toEmail: email) }
        dismiss()
    }
}

extension ForgotPasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return email.isValidEmail()
    }
}

#Preview {
    ForgotPasswordView(viewModel: LoginViewModel(authManager: AuthManager(service: MockAuthService())))
}
