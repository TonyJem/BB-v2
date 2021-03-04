import Foundation

struct Quote: Codable  {
    let id: Int
    let text: String
    let author: String
    let series: String
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case text = "quote"
        case author
        case series
        case isLiked
    }
}
