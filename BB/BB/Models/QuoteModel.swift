import Foundation

class QuoteModel {
    
    var quotes = [Quote]()
    
    var randomQuote: Quote?
    
    var top3Quotes: [Quote] = [ Quote(id: 1, text: "TopQuote1", author: "Author1", series: "BB", isLiked: true),
                                Quote(id: 2, text: "TopYourQuote2", author: "Author1", series: "BB", isLiked: true),
                                Quote(id: 3, text: "TopYourQuote3", author: "Author1", series: "BB", isLiked: true) ]
    
    var yourQuotesTest: [Quote] = [ Quote(id: 4, text: "TestYourQuote1", author: "Author1", series: "BB", isLiked: true),
                                    Quote(id: 5, text: "TestYourQuote2", author: "Author2", series: "BB", isLiked: true),
                                    Quote(id: 6, text: "TestYourQuote3", author: "Author3", series: "BB", isLiked: true),
                                    Quote(id: 7, text: "TestYourQuote4", author: "Author4", series: "BB", isLiked: true),
                                    Quote(id: 8, text: "TestYourQuote5", author: "Author5", series: "BB", isLiked: true),
                                    Quote(id: 9, text: "TestYourQuote6", author: "Author6", series: "BB", isLiked: true) ]
    var likedQuotes = [Quote]()
    
    var tableQuotes = [[Quote]]()
    
    var randomQuoteTest = Quote(id: 10, text: "RandomeQuoteTest", author: "Author1", series: "BB", isLiked: true)
    
    func generateRandomQuote() {
        guard let randomlyGeneratedQuote = quotes.randomElement() else {
            randomQuote = nil
            return
        }
        randomQuote = randomlyGeneratedQuote
    }
    
    func getQuotes(for character: Character) -> [Quote] {
        let filteredQuotes = quotes.filter { quote in
            return quote.author == character.name
        }
        return filteredQuotes
    }
    
    func didSelectQuote(at section: Int, and row: Int) {
        print("🟢 cell did selected at section: \(section) and \(row)")
        
        switch section {
        case 0:
            print("🔴 Do not select Top2 Yet!")
            
        case 1:
            guard let quoteIsLiked = quotes[row].isLiked else {
                quotes[row].isLiked = true
                likedQuotes.append(quotes[row])
                printCurrentResults(for: quotes[row])
                return
            }
            
            if quoteIsLiked {
                quotes[row].isLiked = false
                likedQuotes = likedQuotes.filter(){$0.text != quotes[row].text}
            } else {
                quotes[row].isLiked = true
                likedQuotes.append(quotes[row])
            }
            printCurrentResults(for: quotes[row])
            
        case 2:
            // TODO:
            print("🔴 Do not select Random Yet!")
            
            
            
        default:
            // TODO:
            print("🔴 Default is selected for some reason!")
        }
        
        
    }
    
    private func printCurrentResults(for selectedQuote: Quote) {
        print("🟢 QuoteText Is: \(selectedQuote.text)")
        print("🟡 SelectedQuote isLiked: \(String(describing: selectedQuote.isLiked))")
        for quote in likedQuotes {
            print("🟣 All liked quotes: \(quote.text)")
        }
    }
    
}
