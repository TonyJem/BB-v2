import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?
    private var quoteModel = Core.quoteModel
    private var characterQuotes: [Int: Quote]?
    private var quotesIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsContainerView.quotesTableView.dataSource = self
        characterDetailsContainerView.quotesTableView.tableFooterView = UIView()
        
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
        let cell = UITableViewCell()
        
        guard let characterQuotes = characterQuotes else { return cell }
        
        if let quote = characterQuotes[quotesIDs[indexPath.row]] {
            cell.textLabel?.text = quote.text
        } else {
            cell.textLabel?.text = ""
        }
        return cell
    }

}
