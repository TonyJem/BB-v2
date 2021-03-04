import Foundation

struct Quote: Codable  {
    var text: String
    var isLiked: Bool = false
}


class QuoteModel {

    var top3Quotes: [Quote] = [ Quote(text: "TestTopQuotes1"),
                                   Quote(text: "TestTopQuotes2"),
                                   Quote(text: "TestTopQuotes3", isLiked: true)]
    
    var yourQuotesTest: [Quote] = [ Quote(text: "TestYourQuote1"),
                                   Quote(text: "TestYourQuote2"),
                                   Quote(text: "TestYourQuote3", isLiked: true),
                                   Quote(text: "TestYourQuote4", isLiked: true),
                                   Quote(text: "TestYourQuote5"),
                                   Quote(text: "TestYourQuote6")]
    
    var randomQuote = Quote(text: "TestQuote6", isLiked: true)
    
}
