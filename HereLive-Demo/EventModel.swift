import Foundation

struct Event: Identifiable, Codable {
    var id = UUID()
    let title: String
    let date: EventDate
    let address: [String]
    let link: String
    let thumbnail: String
    let venue: EventVenue
    let ticket_info: [TicketInfo]
}

struct EventDate: Codable {
    let start_date: String
    let when: String
}

struct EventVenue: Codable {
    let name: String
    let rating: Double
    let reviews: Int
    let link: String
}

struct TicketInfo: Codable {
    let source: String
    let link: String
    let link_type: String
}


struct EventsResponse: Codable {
    let eventsResults: [Event]

    enum CodingKeys: String, CodingKey {
        case eventsResults = "events_results"
    }
}

class EventService {
    static let shared = EventService()
    private let apiKey = "50f16a08f9443b8ea3a39cb9768489178ddfe0473db6b709f0c7d9e204021206"
    private let baseUrl = "https://serpapi.com/search.json"

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "engine", value: "google_events"),
            URLQueryItem(name: "q", value: "Events in Austin"),
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
                let eventsResponse = try JSONDecoder().decode(EventsResponse.self, from: data)
                completion(.success(eventsResponse.eventsResults))
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
