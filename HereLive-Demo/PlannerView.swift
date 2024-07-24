//
//  PlannerView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct PlannerView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Plan For Your Next Trip Here")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color.black) // Changed color to green

                HStack(spacing: 40) {
                    NavigationLink(destination: SingleTripView()) {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.orange)
                            Text("Solo Trip")
                                .foregroundColor(Color.green) // Changed color to green
                        }
                    }

                    NavigationLink(destination: CoupleTripView()) {
                        VStack {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.orange)
                            Text("Couple Trip")
                                .foregroundColor(Color.green) // Changed color to green
                        }
                    }

                    NavigationLink(destination: GroupTripView()) {
                        VStack {
                            Image(systemName: "person.3.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.orange)
                            Text("Group Trip")
                                .foregroundColor(Color.green) // Changed color to green
                        }
                    }
                }
                .padding()

                // Dummy Alert for Upcoming Trip
                NavigationLink(destination: UpcomingTripDetailView()) {
                    HStack {
                        Image("disneyImage2")
                            .resizable()
                            .frame(width: 100, height: 60)
                            .cornerRadius(10)
                            .shadow(radius: 3)

                        VStack(alignment: .leading) {
                            Text("View details for your upcoming trip to:")
                                .font(.subheadline)
                                .foregroundColor(Color.black) // Changed color to green
                            Text("DisneyLand, Florida on the 9th of August")
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                        }
                        .padding(.leading, 5)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()
            }
            .navigationBarTitle("Trip Planner")
        }
    }
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}
