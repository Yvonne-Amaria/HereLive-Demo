//
//  ProfileView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//


import SwiftUI
import SafariServices

struct ProfileView: View {
    @State private var showingEditProfile = false
    @State private var showingUploadView = false
    @State private var showingAdventureBucketList = false
    @State private var postCount = 3  // Example post count
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    profileHeader()
                    userInfoSection()
                    postsGrid()
                }
                .navigationBarItems(trailing: menuButton())
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func profileHeader() -> some View {
        VStack {
            Image("profileImage")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Text("Ashley Doe")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 5)
            
            Text("Explorer | Foodie | Dreamer")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button("Edit Profile") {
                showingEditProfile = true
            }
            .foregroundColor(Color.orange)
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
        }
        .padding()
    }
    
    private func userInfoSection() -> some View {
        HStack {
            Spacer()
            VStack {
                Text("\(postCount)")
                    .font(.headline)
                    .foregroundColor(Color.orange)
                Text("Posts")
                    .font(.caption)
            }
            Spacer()
            Button(action: {
                showingUploadView = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.green)
            }
            .sheet(isPresented: $showingUploadView) {
                UploadView()
            }
            Spacer()
            Button(action: {
                showingAdventureBucketList = true
            }) {
                Image(systemName: "suitcase.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.orange)
            }
            .sheet(isPresented: $showingAdventureBucketList) {
                AdventureBucketListView()
            }
            Spacer()
        }
    }
    
    private func postsGrid() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(0..<postCount, id: \.self) { index in
                Image("feedImage\(index + 1)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
            }
        }
        .padding()
    }
    
    private func menuButton() -> some View {
        Menu {
            Button("Settings", action: { /* navigate to SettingsView */ })
            Button("Help/FAQ", action: { /* navigate to HelpView */ })
            Button("Insight", action: { /* navigate to InsightView */ })
            Button("Logout", action: { /* navigate to LogoutView */ })
        } label: {
            Image(systemName: "line.horizontal.3")
                .foregroundColor(Color.green)
                .imageScale(.large)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
