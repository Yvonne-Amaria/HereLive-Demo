//
//  MapView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("Search for places", text: $searchText, onCommit: {
                viewModel.searchQuery(searchText)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.pointsOfInterest) { place in
                MapMarker(coordinate: place.coordinate, tint: .blue)
            }
        }
        .onAppear {
            viewModel.checkLocationAuthorization()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
