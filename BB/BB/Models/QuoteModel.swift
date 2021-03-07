import Foundation

struct likedQuote: Codable {
    let text: String
    var userCount: Int
}

class QuoteModel {
    
    var quotes = [Quote]()
    
    var allLikedQuotes: [likedQuote] {
        get {
            guard let likedQuotes = UserDefaultsManager.likedQuotes else { return [] }
            return likedQuotes
        }
        set(likedQuotes) {
            UserDefaultsManager.likedQuotes = likedQuotes
        }
    }
    
    var top3Quotes: [likedQuote] {
        var top3Quotes = allLikedQuotes
        let counts = allLikedQuotes.map { $0.userCount }
        let uniqueCountsSorted = Array(Set(counts)).sorted(){ $0 > $1 }
        
        if uniqueCountsSorted.count > 3 {
            if let minCount = uniqueCountsSorted[...2].last {
                top3Quotes = allLikedQuotes.filter(){ $0.userCount >= minCount }
            }
        }
        
        return top3Quotes.sorted(){ $0.userCount > $1.userCount }
    }
    
    var favoriteQuotes: [Quote] {
        get {
            guard let favouriteQuotes = UserDefaultsManager.currentAccount?.favouriteQuotes else { return [] }
            return favouriteQuotes
        }
        set(favouriteQuotes) {
            UserDefaultsManager.currentAccount?.favouriteQuotes = favouriteQuotes
        }
    }
    
    var randomQuote = Quote(id: 0, text: "No Random Quote", author: "", series: "")
    
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
        if favoriteQuotes.contains(quote) {
            favoriteQuotes = favoriteQuotes.filter(){$0.text != quote.text}
            removeFromLikedQuotes(quote)
        } else {
            favoriteQuotes.append(quote)
            addToLikedQuotes(quote)
        }
    }
    
    func didSelectFromTop3(quote: likedQuote) {
        print("🟢 Did select Top3Quote: \(quote.text)")
    }
    
    private func addToLikedQuotes(_ quote: Quote) {
        let text = quote.text
        
        if let index = allLikedQuotes.firstIndex(where: { $0.text == text }) {
            allLikedQuotes[index].userCount = +1
        } else {
            let newLikedQuote = likedQuote(text: text, userCount: 1)
            allLikedQuotes.append(newLikedQuote)
        }
    }
    
    private func removeFromLikedQuotes(_ quote: Quote) {
        let text = quote.text
        guard let index = allLikedQuotes.firstIndex(where: { $0.text == text }) else { return }
        if allLikedQuotes[index].userCount <= 1 {
            allLikedQuotes.remove(at: index)
        } else {
            allLikedQuotes[index].userCount = -1
        }
    }
    
}
