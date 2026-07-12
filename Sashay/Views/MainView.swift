//
//  MainView.swift
//  Sashay
//
//  Created by Райымбек Омаров on 12.07.2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            Tab("Home" , systemImage: "home"){
                HomeView()
            }
            Tab("Notifications" , systemImage: "bell"){
                NotifyView()
            }
        }
    }
}

#Preview {
    MainView()
}
