import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let image: String
    let status: String
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case image = "img"
        case status
        case nickname
        case appearance
        case portrayed
        case category
    }
}

