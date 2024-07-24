//
//  HelpView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct HelpView: View {
    let faqs: [FAQ] = [
        FAQ(question: "How do I upload a picture?", answer: "Navigate to the UploadView, tap the 'Upload' button, choose an image, and confirm the upload."),
        FAQ(question: "How do I add a new saving category?", answer: "In the WalletView, tap the '+' icon, enter the name of the new category, and set a goal amount."),
        FAQ(question: "How do I book a hotel?", answer: "Go to the FindHotelsView, search for hotels using your desired criteria, select a hotel, and follow the booking instructions."),
        FAQ(question: "How do I search for events?", answer: "In the DiscoverView, use the search bar to enter your query and view the list of events."),
        FAQ(question: "How do I manage my profile?", answer: "Navigate to the ProfileView where you can edit your bio, change your profile picture, and view your posts."),
        FAQ(question: "What are the payment options?", answer: "The app supports payments through the integrated payment gateway. Navigate to the WalletView to manage your funds and transactions."),
        FAQ(question: "How can I get assistance?", answer: "For further assistance, use the contact form in the app or email support@herelive.com.")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(faqs, id: \.question) { faq in
                    Section(header: Text(faq.question)) {
                        Text(faq.answer)
                            .padding()
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Help & FAQ", displayMode: .inline)
            .listStyle(GroupedListStyle())
        }
    }
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
