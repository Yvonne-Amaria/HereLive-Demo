//
//  SettingsView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var privacySettings = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General").foregroundColor(.orange)) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                }

                Section(header: Text("Privacy").foregroundColor(.orange)) {
                    Toggle("Privacy Settings", isOn: $privacySettings)
                    NavigationLink("Privacy Policy", destination: PrivacyPolicyView())
                }

                Section(header: Text("Account").foregroundColor(.orange)) {
                    NavigationLink("Manage Account", destination: AccountManagementView())
                    NavigationLink("Logout", destination: LogoutView())
                }
                
                Section(header: Text("Support").foregroundColor(.orange)) {
                    NavigationLink("Help", destination: HelpView())
                    NavigationLink("Contact Us", destination: ContactUsView())
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: EditButton())
            .background(Color.green.opacity(0.1))
        }
    }
}

// Placeholder Views for Navigation Links
struct PrivacyPolicyView: View {
    var body: some View {
        Text("Privacy Policy Details Here")
            .navigationTitle("Privacy Policy")
    }
}

struct AccountManagementView: View {
    var body: some View {
        Text("Manage your account settings here.")
            .navigationTitle("Manage Account")
    }
}

struct ContactUsView: View {
    var body: some View {
        Text("Contact Us details here.")
            .navigationTitle("Contact Us")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
