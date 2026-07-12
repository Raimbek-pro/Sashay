//
//  SashayApp.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct SashayApp: App {

    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if authManager.isLoggedIn {
                    MainView()
                } else {
                    LoginView()
                }
            }
            .environment(authManager)
        }
    }
}
