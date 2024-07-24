//
//  ContentView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//


//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var authViewModel = AuthViewModel()  // Manage the view model here
//    @State private var isShowingLandingView = true
//
//    var body: some View {
//        NavigationView {
//            if isShowingLandingView {
//                LandingView {
//                    isShowingLandingView = false
//                }
//            } else {
//                if authViewModel.isAuthenticated {
//                    MainTabView()
//                } else {
//                    LoginView()
//                        .environmentObject(authViewModel) // Pass the AuthViewModel here
//                }
//            }
//        }
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct MainTabView: View {
//
//    var body: some View {
//        TabView {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person")
//                }
//
//            DiscoverView()
//                .tabItem {
//                    Label("Discover", systemImage: "magnifyingglass")
//                }
//
//            PlannerView()
//                .tabItem {
//                    Label("Planner", systemImage: "calendar")
//                }
//
//            WalletView()
//                .tabItem {
//                    Label("Wallet", systemImage: "wallet.pass")
//                }
//        }
//    }
//}
//
//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
//





import SwiftUI
import Firebase


struct ContentView: View {
    @State private var isShowingLandingView = true
    @State private var isAuthenticated = false

    init() {
        // Check Firebase Authentication status
        isAuthenticated = Auth.auth().currentUser != nil
    }

    var body: some View {
        NavigationView {
            if isShowingLandingView {
                LandingView {
                    isShowingLandingView = false
                }
            } else {
                if isAuthenticated {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
            
            PlannerView()
                .tabItem {
                    Label("Planner", systemImage: "calendar")
                }
            
            WalletView()
                .tabItem {
                    Label("Wallet", systemImage: "wallet.pass")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
