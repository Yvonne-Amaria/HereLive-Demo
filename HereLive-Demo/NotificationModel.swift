//
//  NotificationModel.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import Foundation
import Combine

struct Notification: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let timestamp: String
}

class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []

    init() {
        loadNotifications()
    }

    private func loadNotifications() {
        // Dummy data for notifications
        notifications = [
            Notification(title: "New Follow", message: "Alex has saved your post to their Adventure BucketList!", timestamp: "2m ago"),
            Notification(title: "Event Reminder", message: "Don't forget: Saving for your trip to Disneyland starts tomorrow!", timestamp: "1h ago"),
            Notification(title: "New Likes", message: "Your recent post about Bali has received 25 likes!", timestamp: "5h ago"),
            Notification(title: "Comment", message: "Sarah commented: 'Amazing view!' on your post from Austin.", timestamp: "1d ago")
        ]
    }
}

