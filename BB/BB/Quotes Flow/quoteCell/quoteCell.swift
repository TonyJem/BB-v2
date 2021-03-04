import UIKit

class quoteCell: UITableViewCell {
    
    @IBOutlet weak private var iconButton: UIButton!
    @IBOutlet weak private var quoteTextLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func iconButtonTapped(_ sender: UIButton) {
    }
    
    func fillContent(with quote: Quote) {
        quoteTextLabel.text = quote.text
//        if quote.isLiked {
//            iconButton.setImage(UIImage(named: "heartIcon"), for: .normal)
//        } else {
//            iconButton.setImage(UIImage(named: "unselectedHeard"), for: .normal)
//        }
    }
    
}
