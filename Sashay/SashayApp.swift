//
//  SashayApp.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import SwiftUI



@main
struct SashayApp: App {

    @State private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if authManager.isLoggedIn {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .environment(authManager)
        }
    }
}
