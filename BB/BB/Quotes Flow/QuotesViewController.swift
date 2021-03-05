import UIKit

class QuotesViewController: UIViewController {

    @IBOutlet weak private var quotesTableview: UITableView!
    
    private let model = Core.Quotes
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        quotesTableview.register(UINib(nibName: String(describing: quoteCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: quoteCell.self))
        
        quotesTableview.dataSource = self
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
            return model.top3Quotes.count
        case 1:
            return model.quotes.count
        case 2:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = quotesTableview.dequeueReusableCell(withIdentifier: String(describing: quoteCell.self), for: indexPath) as? quoteCell else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
//            cell.fillContent(with: model.top3Quotes[indexPath.row])
            cell.textLabel?.text = model.top3Quotes[indexPath.row].text
            return cell
        case 1:
//            cell.fillContent(with: model.yourQuotesTest[indexPath.row])
            cell.textLabel?.text = model.quotes[indexPath.row].text
            return cell
        case 2:
//            cell.fillContent(with: model.randomQuote)
            if let randomQuote = model.randomQuote {
                cell.textLabel?.text = randomQuote.text
            } else {
                cell.textLabel?.text = "No quotes to show!"
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
