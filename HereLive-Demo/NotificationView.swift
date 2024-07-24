//
//  NotificationView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.notifications) { notification in
                VStack(alignment: .leading, spacing: 5) {
                    Text(notification.title)
                        .font(.headline)
                        .foregroundColor(.orange)

                    Text(notification.message)
                        .font(.subheadline)

                    Text(notification.timestamp)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationBarTitle("Notifications", displayMode: .inline)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

