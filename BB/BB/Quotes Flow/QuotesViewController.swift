import UIKit

class QuotesViewController: UIViewController {
    
    @IBOutlet weak private var quotesTableview: UITableView!
    
    private let quoteModel = Core.quoteModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotesTableview.register(UINib(nibName: String(describing: quoteCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: quoteCell.self))
        
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
            return quoteModel.quotes.count
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
            cell.fillContent(with: quoteModel.top3Quotes[indexPath.row])
            return cell
        case 1:
            cell.fillContent(with: quoteModel.quotes[indexPath.row])
            return cell
        case 2:
            if let randomQuote = quoteModel.randomQuote {
                cell.fillContent(with: randomQuote)
            } else {
                cell.textLabel?.text = "No quotes to show!"
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension QuotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        quoteModel.didSelectQuote(at: indexPath.section, and: indexPath.row)
        
        tableView.reloadData()
    }
    
}
