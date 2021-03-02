import Foundation

enum APIEndpoint {
    case episodes
    case characters
 
    var url: URL? {
        switch self {
        case .episodes:
            return makeURL(endpoint: "episodes/")
        case .characters:
            return makeURL(endpoint: "characters/")
        }
    }
}

private extension APIEndpoint {

    var BaseURL: String {
        "https://www.breakingbadapi.com/api/"
    }

    func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseURL + endpoint

        guard let queryItems = queryItems else {
            return URL(string: urlString)
        }

        var components = URLComponents(string: urlString)
        components?.queryItems = queryItems
        return components?.url
    }
    
}
