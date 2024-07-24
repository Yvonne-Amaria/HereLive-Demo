//
//  FindHotelsView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct HotelRow: View {
    var hotel: Hotel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(hotel.name)
                .font(.headline)
                .foregroundColor(Color.orange)

            Text(hotel.description)
                .font(.subheadline)
                .foregroundColor(Color.gray)

            HStack {
                Text("Check-in: \(hotel.checkInTime)")
                Spacer()
                Text("Check-out: \(hotel.checkOutTime)")
            }
            .font(.caption)
            .foregroundColor(Color.green)

            if let logoURL = URL(string: hotel.logo) {
                AsyncImage(url: logoURL) { image in
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

struct FindHotelsView: View {
    @State private var hotels: [Hotel] = []
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
                    ForEach(hotels) { hotel in
                        HotelRow(hotel: hotel)
                    }
                }
            }
            .navigationBarTitle("Find Hotels")
            .onAppear(perform: loadHotels)
        }
    }

    private func loadHotels() {
        isLoading = true
        HotelService.shared.fetchHotels { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let hotels):
                    self.hotels = hotels
                case .failure(let error):
                    self.errorMessage = "Failed to fetch hotels: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct FindHotelsView_Previews: PreviewProvider {
    static var previews: some View {
        FindHotelsView()
    }
}
