import Foundation

struct Account: Codable {
    
    let username: String
    var password: String
    var favouriteQuotes: [Quote]
    
    init(username: String, password: String, favouriteQuotes: [Quote]) {
        self.username = username
        self.password = password
        self.favouriteQuotes = favouriteQuotes
    }
    
}

struct Quote: Codable  {
    var text: String
}




