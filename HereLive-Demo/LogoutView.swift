//
//  LogoutView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct LogoutView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Sad To See You Log Out 😢")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.orange)
                
                Text("Don't Forget To Come Back For More Adventures!")
                    .font(.headline)
                    .foregroundColor(Color.green)
                
                Button(action: logout) {
                    Text("Log Out")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Logout")
        }
    }
    
    private func logout() {
        // Here you would normally handle the logout logic like clearing user data, etc.
        // After handling logout, navigate back to the LoginView
        presentationMode.wrappedValue.dismiss()
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
