//
//  HotelModel.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import Foundation

struct Hotel: Identifiable, Codable {
    var id: UUID { UUID() }  // This makes `id` a read-only computed property
    let name: String
    let description: String
    let checkInTime: String
    let checkOutTime: String
    let ratePerNight: Rate
    let logo: String
    let gpsCoordinates: GPSCoordinates
}

struct Rate: Codable {
    let lowest: String
    let extractedLowest: Double
}

struct GPSCoordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct HotelsResponse: Codable {
    let properties: [Hotel]

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

class HotelService {
    static let shared = HotelService()
    private let apiKey = "50f16a08f9443b8ea3a39cb9768489178ddfe0473db6b709f0c7d9e204021206"
    private let baseUrl = "https://serpapi.com/search.json"

    func fetchHotels(completion: @escaping (Result<[Hotel], Error>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "engine", value: "google_hotels"),
            URLQueryItem(name: "q", value: "Hotels in Bali"),
            URLQueryItem(name: "check_in_date", value: "2024-04-23"),
            URLQueryItem(name: "check_out_date", value: "2024-04-24"),
            URLQueryItem(name: "hl", value: "en"),
            URLQueryItem(name: "gl", value: "us"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        let request = URLRequest(url: components.url!)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknown))
                return
            }

            do {
                let hotelsResponse = try JSONDecoder().decode(HotelsResponse.self, from: data)
                completion(.success(hotelsResponse.properties))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    enum NetworkError: Error {
        case invalidURL
        case unknown
    }
}
