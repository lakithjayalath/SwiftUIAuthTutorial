//
//  RegistrationView.swift
//  SwiftUIAuthTutorial
//
//  Created by Lakith Jayalath on 2023-11-01.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("firebase-logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeHolder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $fullName,
                          title: "Full Name",
                          placeHolder: "Enter your name")
                
               InputView(text: $password,
                         title: "Password",
                         placeHolder: "Enter your password",
                         isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeHolder: "Confirm your password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail:email,
                                                   password:password,
                                                   fullName: fullName)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

// Mark: - AuthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol {
    
    var formIsValid: Bool {
        return !email.isEmpty 
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
    
}

#Preview {
    RegistrationView()
}
