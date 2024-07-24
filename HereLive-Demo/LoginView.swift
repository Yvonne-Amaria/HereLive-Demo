//
//  LoginView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("logoImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 50)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.green.opacity(0.2))
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.green.opacity(0.2))

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button("Login") {
                    login()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()

                NavigationLink(value: "SignUp") {
                    Text("Don't have an account? Sign Up")
                }
                .foregroundColor(Color.green)
                .padding()

                NavigationLink(destination: MainTabView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "SignUp" {
                    SignUpView()
                }
            }
            .navigationTitle("Login")
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = result {
                self.isLoggedIn = true
            } else if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
