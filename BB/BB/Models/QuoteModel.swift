import Foundation

class QuoteModel {
    
    var quotes = [Quote]()
    
    var randomQuote = Quote(id: 0, text: "No Random Quote", author: "", series: "")
    
    var top3Quotes: [Quote] = [ Quote(id: 1, text: "TopQuote1", author: "Author1", series: "BB"),
                                Quote(id: 2, text: "TopYourQuote2", author: "Author1", series: "BB"),
                                Quote(id: 3, text: "TopYourQuote3", author: "Author1", series: "BB") ]
    
    var likedQuotes: [Quote] {
        get {
            guard let favouriteQuotes = AccountManager.loggedInAccount?.favouriteQuotes else { return [] }
            return favouriteQuotes
        }
        set(likedQuotes) {
            AccountManager.loggedInAccount?.favouriteQuotes = likedQuotes
        }
    }
    
    var tableQuotes = [[Quote]]()
    
    func generateRandomQuote() {
        guard let randomlyGeneratedQuote = quotes.randomElement() else { return }
        randomQuote = randomlyGeneratedQuote
    }
    
    func getQuotes(for character: Character) -> [Quote] {
        let filteredQuotes = quotes.filter { quote in
            return quote.author == character.name
        }
        return filteredQuotes
    }
    
    func didSelect(quote: Quote) {
        if likedQuotes.contains(quote) {
            likedQuotes = likedQuotes.filter(){$0.text != quote.text}
        } else {
            likedQuotes.append(quote)
        }
    }
    
}
