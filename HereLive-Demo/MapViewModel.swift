//
//  MapViewModel.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        latitudinalMeters: 1000,
        longitudinalMeters: 1000
    )
    @Published var pointsOfInterest: [PointOfInterest] = []

    var locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }

    func checkLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            print("Location permission is not adequate.")
        }
    }

    // Function to handle search query
    func searchQuery(_ query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let strongSelf = self, let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            strongSelf.pointsOfInterest = response.mapItems.map { item in
                PointOfInterest(name: item.name ?? "Unknown", coordinate: item.placemark.coordinate)
            }
        }
    }
}

struct PointOfInterest: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
