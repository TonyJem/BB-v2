import UIKit

class quoteCell: UITableViewCell {
    
    @IBOutlet weak private var quoteTextLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    
    func fillContent(with quote: Quote) {
        quoteTextLabel.text = quote.text
        
//        TODO: Refactor that palce to keep unwrap and false in same guard
        guard let isQuoteLiked = quote.isLiked else {
            iconImageView.image = UIImage(named: "unselectedHeart")
            return
        }
        iconImageView.image = isQuoteLiked ? UIImage(named: "heartIcon") : UIImage(named: "unselectedHeart")
    }
    
}
