import Foundation

struct Quote: Codable, Equatable  {
    let id: Int
    let text: String
    let author: String
    let series: String
    
    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case text = "quote"
        case author
        case series
    }
}
