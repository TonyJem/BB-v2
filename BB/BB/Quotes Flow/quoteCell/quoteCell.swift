import UIKit

class quoteCell: UITableViewCell {
    
    @IBOutlet weak private var quoteTextLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    
    func fillContent(with quote: Quote) {
        quoteTextLabel.text = quote.text
        
        if Core.quoteModel.favoriteQuotes.contains(quote) {
            iconImageView.image = UIImage(named: "heartIcon")
        } else {
            iconImageView.image = UIImage(named: "unselectedHeart")
        }
        
    }
    
    func fillContentInTop3Quotes(with quote: likedQuote) {
        quoteTextLabel.text = quote.text
        
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
