import UIKit

class quoteCell: UITableViewCell {
    
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func fillContent(with quote: Quote) {
        quoteTextLabel.text = quote.text
        
        if Core.quoteModel.favoriteQuotes.contains(quote) {
            iconImageView.image = UIImage(named: "heartIcon")
        } else {
            iconImageView.image = UIImage(named: "unselectedHeart")
        }
        
    }
    
}
