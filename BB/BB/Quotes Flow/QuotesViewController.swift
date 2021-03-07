import UIKit

class QuotesViewController: UIViewController {
    
    @IBOutlet weak private var quotesTableview: UITableView!
    
    private let quoteModel = Core.quoteModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotesTableview.register(UINib(nibName: String(describing: quoteCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: quoteCell.self))
        
        quotesTableview.register(UINib(nibName: String(describing: top3QuoteCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: top3QuoteCell.self))
        
        quotesTableview.dataSource = self
        quotesTableview.delegate = self
        quotesTableview.tableFooterView = UIView()
    }
    
}

extension QuotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Top 3 favourite quotes"
        case 1:
            return "Your quotes"
        case 2:
            return "Random quote"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return quoteModel.top3Quotes.count
        case 1:
            return quoteModel.favoriteQuotes.count
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = quotesTableview.dequeueReusableCell(withIdentifier: String(describing: quoteCell.self), for: indexPath) as? quoteCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            
            guard let cell = quotesTableview.dequeueReusableCell(withIdentifier: String(describing: top3QuoteCell.self), for: indexPath) as? top3QuoteCell else { return UITableViewCell() }
            
            cell.fillContentInTop3Quotes(with: quoteModel.top3Quotes[indexPath.row])
            return cell
        case 1:
            cell.fillContent(with: quoteModel.favoriteQuotes[indexPath.row])
            return cell
        case 2:
            cell.fillContent(with: quoteModel.randomQuote)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension QuotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            quoteModel.didSelectFromTop3(quote: quoteModel.top3Quotes[indexPath.row])
        case 1:
            quoteModel.didSelect(quote: quoteModel.favoriteQuotes[indexPath.row])
        case 2:
            quoteModel.didSelect(quote: quoteModel.randomQuote)
        default:
//            TODO: Add enum so do not need default in switch
            print("Unexpected default section")
        }
        
        tableView.reloadData()
    }
    
}
