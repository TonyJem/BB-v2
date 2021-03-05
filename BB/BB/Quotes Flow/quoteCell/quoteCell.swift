import UIKit

class quoteCell: UITableViewCell {
    
    @IBOutlet weak private var quoteTextLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    
    func fillContent(with quote: Quote) {
        quoteTextLabel.text = quote.text
        guard let isQuoteLiked = quote.isLiked else { return }
        
        iconImageView.image = isQuoteLiked ? UIImage(named: "heartIcon") : UIImage(named: "unselectedHeart")
    }
    
}
