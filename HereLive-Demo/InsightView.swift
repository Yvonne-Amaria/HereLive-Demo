//
//  InsightView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct InsightView: View {
    @State private var savingStreak = 23
    @State private var totalSavings = 1200.00
    @State private var mostLikedPostLikes = 342
    @State private var mostLikedPostImage = "feedImage2"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Your Insights")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                        .padding()

                    InsightMetricView(title: "Saving Streak", value: "\(savingStreak) Days", icon: "flame.fill")
                        .padding(.horizontal)

                    InsightMetricView(title: "Total Savings", value: String(format: "$%.2f", totalSavings), icon: "dollarsign.circle.fill")
                        .padding(.horizontal)

                    MostLikedPostView(likes: mostLikedPostLikes, imageName: mostLikedPostImage)

                    Spacer()
                }
            }
            .background(Color.green.opacity(0.1))
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct InsightMetricView: View {
    var title: String
    var value: String
    var icon: String

    var body: some View {
        VStack {
            Label(value, systemImage: icon)
                .font(.title)
                .foregroundColor(.green)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct MostLikedPostView: View {
    let likes: Int
    let imageName: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Most Liked Post")
                .font(.headline)
                .padding(.leading)
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text("Likes: \(likes)")
                        .foregroundColor(.orange)
                    Text("This post received the most likes!")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct InsightView_Previews: PreviewProvider {
    static var previews: some View {
        InsightView()
    }
}
