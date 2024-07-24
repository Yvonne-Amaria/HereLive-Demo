//
//  DiscoverView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct EventRow: View {
    var event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(event.title)
                .font(.headline)
                .foregroundColor(Color.orange)

            HStack {
                Text(event.date.start_date)  // Accessing start_date correctly
                Spacer()
                Text(event.address.joined(separator: ", "))
            }
            .font(.subheadline)
            .foregroundColor(Color.gray)

            Link("Details", destination: URL(string: event.link)!)
                .font(.caption)
                .foregroundColor(.blue)
            
            if let thumbnailURL = URL(string: event.thumbnail) {
                AsyncImage(url: thumbnailURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            }
        }
        .padding(.vertical)
    }
}

struct DiscoverView: View {
    @State private var events: [Event] = []
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            List {
                if isLoading {
                    ProgressView()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                } else {
                    TextField("Search events...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    ForEach(events) { event in
                        EventRow(event: event)
                    }
                }
            }
            .navigationBarTitle("Discover Events")
            .onAppear(perform: loadEvents)
        }
    }

    private func loadEvents() {
        isLoading = true
        EventService.shared.fetchEvents { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    self.errorMessage = "Failed to fetch events: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
