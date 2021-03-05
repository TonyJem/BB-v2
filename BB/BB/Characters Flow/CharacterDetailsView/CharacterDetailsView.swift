import UIKit

class CharacterDetailsView: UIView {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var birthdayLabel: UILabel!
    @IBOutlet weak var quotesTableView: UITableView!
    
    private var quotesView: UIView!
    private var xibName: String = "CharacterDetailsView"
    
    var nameLabelText: String {
        get {
            guard let text = nameLabel.text else { return "" }
            return text
        }
        set(nameLabelText) {
            nameLabel.text = nameLabelText
        }
    }
    
    var birthdayLabelText: String {
        get {
            guard let text = birthdayLabel.text else { return "" }
            return text
        }
        set(birthdayLabelText) {
            birthdayLabel.text = birthdayLabelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setQuotesView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setQuotesView()
    }
    
    private func setQuotesView() {
        quotesView = getFromXib()
        quotesView.frame = bounds
        quotesView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(quotesView)
    }
    
    private func getFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: xibName, bundle: bundle)
        guard let view = xib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }
    
}
