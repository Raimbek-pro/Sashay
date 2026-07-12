//
//  NotifyView.swift
//  Sashay
//
//  Created by Райымбек Омаров on 12.07.2026.
//

import SwiftUI
import UserNotifications

struct NotifyView: View {
    var body: some View {
        VStack{
            Button("Request permission"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    } else if let error {
                        print(error.localizedDescription )
                    }
                }
            }
            Button("Schedule notification"){
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add( request)
            }
        }
    }
}

#Preview {
    NotifyView()
}
