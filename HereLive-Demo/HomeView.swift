//
//  HomeView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.

//import SwiftUI
//
//struct HomeView: View {
//    var posts: [Post] = [
//        Post(id: UUID(), user: User(id: UUID(), username: "Disneyland Visit", profileImage: Image("disneyImage")), image: Image("disneyImage"), timestamp: "Just now", location: "Disneyland"),
//        Post(id: UUID(), user: User(id: UUID(), username: "Beyoncé Concert", profileImage: Image("beyImage")), image: Image("beyImage"), timestamp: "1 hour ago", location: "Moody Center Austin")
//    ]
//
//    var body: some View {
//        NavigationView {
//            List(posts) { post in
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack {
//                        post.user.profileImage
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .clipShape(Circle())
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text(post.user.username)
//                                .font(.headline)
//                                .foregroundColor(Color.orange) // Text color changed to orange
//                            Text(post.location)
//                                .font(.subheadline)
//                                .foregroundColor(Color.orange) // Text color changed to orange
//                        }
//                        Spacer()
//                        Button(action: {
//                            // Save action
//                        }) {
//                            Image(systemName: "bookmark")
//                                .font(.title)
//                                .foregroundColor(Color.green) // Icon color changed to green
//                        }
//                    }
//                    post.image
//                        .resizable()
//                        .scaledToFit()
//                    HStack {
//                        Button(action: {
//                            // Like action
//                        }) {
//                            Image(systemName: "heart")
//                                .font(.title2)
//                                .foregroundColor(Color.green) // Icon color changed to green
//                        }
//                        Spacer()
//                        Button(action: {
//                            // Comment action
//                        }) {
//                            Image(systemName: "message")
//                                .font(.title2)
//                                .foregroundColor(Color.green) // Icon color changed to green
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .padding(.vertical)
//            }
//            .navigationBarTitle(Text("Here, Live").foregroundColor(Color.orange), displayMode: .inline) // Navigation bar title color
//            .navigationBarItems(
//                leading: Text("Here, Live").font(.headline).foregroundColor(Color.orange), // Leading text color
//                trailing: HStack {
//                    Button(action: {
//                        // Notification action
//                    }) {
//                        Image(systemName: "bell.fill")
//                            .font(.title)
//                            .foregroundColor(Color.green) // Icon color changed to green
//                    }
//                    NavigationLink(destination: ChatView()) {
//                        Image(systemName: "message.fill")
//                            .font(.title)
//                            .foregroundColor(Color.green) // Icon color changed to green
//                    }
//                }
//            )
//        }
//    }
//}
//
//struct Post: Identifiable {
//    let id: UUID
//    let user: User
//    let image: Image
//    let timestamp: String
//    let location: String
//}
//
//struct User: Identifiable {
//    let id: UUID
//    let username: String
//    let profileImage: Image
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

import SwiftUI

struct HomeView: View {
    @State private var posts: [Post] = [
        Post(id: UUID(), user: User(id: UUID(), username: "Disneyland Visit", profileImage: "disneyImage"), image: "disneyImage", timestamp: "Just now", location: "Disneyland"),
        Post(id: UUID(), user: User(id: UUID(), username: "Beyoncé Concert", profileImage: "beyImage"), image: "beyImage", timestamp: "1 hour ago", location: "Moody Center Austin")
    ]
    @State private var showingSaveOptions = false
    @State private var selectedPost: Post?

    var body: some View {
        NavigationView {
            List(posts) { post in
                VStack(alignment: .leading, spacing: 8) {
                    PostHeaderView(post: post, saveAction: {
                        selectedPost = post
                        showingSaveOptions = true
                    })
                    PostImageView(imageName: post.image)
                    PostActionView()
                }
                .padding(.vertical)
            }
            .sheet(isPresented: $showingSaveOptions) {
                SaveOptionsView(post: $selectedPost)
            }
            .navigationBarTitle(Text("Here, Live"), displayMode: .inline)
            .navigationBarItems(leading: HeaderTextView(), trailing: NavigationLinksView())
        }
    }
}

struct PostHeaderView: View {
    var post: Post
    var saveAction: () -> Void

    var body: some View {
        HStack {
            Image(post.user.profileImage)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(post.user.username).font(.headline).foregroundColor(.orange)
                Text(post.location).font(.subheadline).foregroundColor(.orange)
            }
            Spacer()
            Button(action: saveAction) {
                Image(systemName: "bookmark").font(.title).foregroundColor(.green)
            }
        }
    }
}

struct PostImageView: View {
    var imageName: String

    var body: some View {
        Image(imageName).resizable().scaledToFit()
    }
}

struct PostActionView: View {
    var body: some View {
        HStack {
            Button(action: {}) { Image(systemName: "heart").font(.title2).foregroundColor(.green) }
            Spacer()
            Button(action: {}) { Image(systemName: "message").font(.title2).foregroundColor(.green) }
        }
        .padding(.horizontal)
    }
}

struct SaveOptionsView: View {
    @Binding var post: Post?

    var body: some View {
        VStack(spacing: 20) {
            Text("Save to Bucket List").font(.headline)
            Button("Adventure") {
                savePost(category: "Adventure")
            }
            Button("Event") {
                savePost(category: "Event")
            }
        }
    }

    private func savePost(category: String) {
        guard let post = post else { return }
        // Code to save the post to the selected category
        print("Saving \(post.user.username)'s post to \(category)")
    }
}

struct HeaderTextView: View {
    var body: some View {
        Text("Here, Live").font(.headline).foregroundColor(.orange)
    }
}

struct NavigationLinksView: View {
    var body: some View {
        HStack {
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell.fill").font(.title).foregroundColor(.green)
            }
            NavigationLink(destination: ChatView()) {
                Image(systemName: "message.fill").font(.title).foregroundColor(.green)
            }
        }
    }
}

// Define your Post, User models here as before
// Add previews and other necessary subviews or utilities


struct Post: Identifiable {
    let id: UUID
    let user: User
    let image: String
    let timestamp: String
    let location: String
}

struct User: Identifiable {
    let id: UUID
    let username: String
    let profileImage: String
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
