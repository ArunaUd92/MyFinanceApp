//
//  ContentView.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 20/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LoginViewModel(authUseCase: AuthenticationUseCase(authService: AuthenticationService()))
    

    var body: some View {
        NavigationView {
            VStack {
                Divider()
                Text("MyFinance")
                    .font(.largeTitle)
                    .padding(.vertical, 55.0)
                
                Spacer()
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 15)
                
                if !viewModel.isEmailValid {
                    Text("Invalid email address")
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                
                if !viewModel.isPasswordValid {
                    Text("Password must be at least 8 characters")
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                
               
                Button("Forgot Password?") {
                    // Forgot password action
                }
                .padding(.bottom, 20)

                Button("LOGIN") {
                    // Login action
                    viewModel.login()
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5.0)
                .disabled(!viewModel.isEmailValid || !viewModel.isPasswordValid)
                
                Spacer()
                
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Signup here")
                }
            }
            .padding([.leading, .trailing], 15.0)
            // Add alert for error messages
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    ContentView()
}


struct SignUpView: View {
    var body: some View {
        Text("Sign Up View")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
