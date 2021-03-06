import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?
    private var quoteModel = Core.quoteModel
    private var characterQuotes: [Int: Quote]?
    private var quotesIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tableView = characterDetailsContainerView.quotesTableView else { return }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: String(describing: quoteCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: quoteCell.self))
        
        guard let character = character else { return }
        characterDetailsContainerView.nameLabelText = character.name
        characterDetailsContainerView.birthdayLabelText = character.birthday
        
        characterQuotes = quoteModel.getQuotesFromDict(for: character)
        guard let characterQuotes = characterQuotes else { return }
        quotesIDs = Array(characterQuotes.keys).sorted {$0 < $1}
    }
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotesIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: quoteCell.self), for: indexPath) as? quoteCell else { return UITableViewCell() }
        
        guard let characterQuotes = characterQuotes else { return cell }
        
        if let quote = characterQuotes[quotesIDs[indexPath.row]] {
            cell.fillContent(with: quote)
        } else {
//            TODO: Need to put some solution in case empty cell
            cell.textLabel?.text = ""
        }
        return cell
    }

}

extension CharacterDetailsViewController: UITableViewDelegate {
    
}
