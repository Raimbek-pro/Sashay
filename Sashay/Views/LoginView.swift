//
//  ContentView.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import SwiftUI


struct LoginView: View {
    @State private var isLoading = false
    @State private var isLoggedIn = false
    private var authService : AuthService = AuthService()
    
    @Environment(AuthManager.self) private var authManager
    var body: some View {

        VStack {
            Spacer()
            Button("log in with genius") {
                Task {
                    isLoading = true
                    let result =  await authService.authGenius()
                    isLoading = false
                    switch result {
                    case .success(let token) :
                        KeychainService.shared.save(token: token.accessToken)
                        isLoggedIn = true
                        authManager.isLoggedIn = true
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            .padding()
            .frame(maxWidth : .infinity)
            .buttonStyle(GreenButton())
        
           
   
            
        }
        .padding()
        .navigationDestination(isPresented: $isLoggedIn){
            HomeView()
        }
    }
}

#Preview {

    NavigationStack {

        LoginView()

    }

    .environment(AuthManager())

}
