import Foundation

class QuoteModel {
    
    var quotes = [Quote]()
    
    var quotesById: [Int: Quote] {
        quotes.toDictionary { $0.id }
    }
    
    var randomQuote = Quote(id: 0, text: "No Random Quote", author: "", series: "", isLiked: false)
    
    var top3Quotes: [Quote] = [ Quote(id: 1, text: "TopQuote1", author: "Author1", series: "BB", isLiked: true),
                                Quote(id: 2, text: "TopYourQuote2", author: "Author1", series: "BB", isLiked: true),
                                Quote(id: 3, text: "TopYourQuote3", author: "Author1", series: "BB", isLiked: true) ]
    
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
    
    func getQuotesFromDict(for character: Character) -> [Int: Quote] {
        let filteredQuotes = quotesById.filter { $0.value.author == character.name
        }
        return filteredQuotes
    }
    
    func didSelectQuote(at section: Int, and row: Int) {
        print("🟢 cell did selected at section: \(section) and \(row)")
        
        switch section {
        case 0:
            print("🔴 Do not select Top2 Yet!")
            
        case 1:
            guard let quoteIsLiked = likedQuotes[row].isLiked else {
                likedQuotes[row].isLiked = true
                likedQuotes.append(likedQuotes[row])
                return
            }
            
            if quoteIsLiked {
                likedQuotes[row].isLiked = false
                if likedQuotes[row].text == randomQuote.text {
                    randomQuote.isLiked = false
                }
                likedQuotes = likedQuotes.filter(){$0.text != likedQuotes[row].text}
            } else {
                likedQuotes[row].isLiked = true
                likedQuotes.append(quotes[row])
            }
            
            
        case 2:
            guard let quoteIsLiked = randomQuote.isLiked else {
// TODO: remove when not needed
  print(quotesById[randomQuote.id]?.text as Any)
                
                randomQuote.isLiked = true
                likedQuotes.append(randomQuote)
                return
            }
            
            if quoteIsLiked {
                randomQuote.isLiked = false
                likedQuotes = likedQuotes.filter(){$0.text != randomQuote.text}
            } else {
                randomQuote.isLiked = true
                likedQuotes.append(randomQuote)
            }
            
        default:
            // TODO:
            print("🔴 Default is selected for some reason!")
        }
        
    }
    
}
