//
//  SignUpView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//


import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isSignedUp = false

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

                Button("Sign Up") {
                    register()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()

                NavigationLink(value: "Login") {
                    Text("Already have an account? Login")
                }
                .foregroundColor(Color.green)
                .padding()

                NavigationLink(destination: MainTabView(), isActive: $isSignedUp) {
                    EmptyView()
                }
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "Login" {
                    LoginView()
                }
            }
            .navigationTitle("Sign Up")
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let _ = result {
                self.isSignedUp = true
            } else if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
