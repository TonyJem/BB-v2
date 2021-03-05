import Foundation

class QuoteModel {
    
    var allQuotes = [Quote]()
    
    var randomQuote: Quote?
    
    var quotes: [Quote] {
        let filteredQuotes = allQuotes.filter { quote in
            return quote.series == "Breaking Bad"
        }
        return filteredQuotes
    }
    
    var top3Quotes: [Quote] = [ Quote(id: 1, text: "TopQuote1", author: "Author1", series: "BB", isLiked: true),
                                Quote(id: 2, text: "TopYourQuote2", author: "Author1", series: "BB", isLiked: true),
                                Quote(id: 3, text: "TopYourQuote3", author: "Author1", series: "BB", isLiked: true) ]
    
    var yourQuotesTest: [Quote] = [ Quote(id: 4, text: "TestYourQuote1", author: "Author1", series: "BB", isLiked: true),
                                    Quote(id: 5, text: "TestYourQuote2", author: "Author2", series: "BB", isLiked: true),
                                    Quote(id: 6, text: "TestYourQuote3", author: "Author3", series: "BB", isLiked: true),
                                    Quote(id: 7, text: "TestYourQuote4", author: "Author4", series: "BB", isLiked: true),
                                    Quote(id: 8, text: "TestYourQuote5", author: "Author5", series: "BB", isLiked: true),
                                    Quote(id: 9, text: "TestYourQuote6", author: "Author6", series: "BB", isLiked: true) ]
    
    var randomQuoteTest = Quote(id: 10, text: "RandomeQuoteTest", author: "Author1", series: "BB", isLiked: true)
    
    func generateRandomQuote() {
        guard let randomlyGeneratedQuote = quotes.randomElement() else {
            randomQuote = nil
            return
        }
        randomQuote = randomlyGeneratedQuote
    }
    
    func getQuotes(for character: Character) -> [Quote] {
        let filteredQuotes = allQuotes.filter { quote in
            return quote.author == character.name
        }
        return filteredQuotes
    }
    
}
