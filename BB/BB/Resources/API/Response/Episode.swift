import Foundation

struct Episode: Codable {
    let id: Int
    let title: String
    let seasonNumber: String
    let airDate: String
    let characters: [String]
    let episodeNumber: String
    let series: String
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case seasonNumber = "season"
        case airDate = "air_date"
        case characters
        case episodeNumber = "episode"
        case series
    }
}

