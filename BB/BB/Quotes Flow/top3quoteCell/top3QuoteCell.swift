import UIKit

class top3QuoteCell: quoteCell {
 
    @IBOutlet weak private var likesCountLabel: UILabel!
    
    func fillContentInTop3Quotes(with quote: likedQuote) {
        quoteTextLabel.text = quote.text
        likesCountLabel.text = String(quote.userCount)
        
        let filteredQuotes = Core.quoteModel.favoriteQuotes.filter { userFavoriteQuote in
            return userFavoriteQuote.text == quote.text
        }
        
        if filteredQuotes.isEmpty {
            iconImageView.image = UIImage(named: "unselectedHeart")
        } else {
            iconImageView.image = UIImage(named: "heartIcon")
        }
        
    }
    
}
