import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?
    private var quoteModel = Core.quoteModel
    private var characterQuotesDict: [Int: Quote]?
    private var quotesIDs: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsContainerView.quotesTableView.dataSource = self
        characterDetailsContainerView.quotesTableView.tableFooterView = UIView()
        
        guard let character = character else { return }
        characterDetailsContainerView.nameLabelText = character.name
        characterDetailsContainerView.birthdayLabelText = character.birthday
        
        print("🟢 all Quotes: \(quoteModel.quotes)")
        
        characterQuotesDict = quoteModel.getQuotesFromDict(for: character)
        
        guard let characterQuotesDict = characterQuotesDict else { return }
        quotesIDs = Array(characterQuotesDict.keys).sorted {$0 < $1}

    }
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let quotesIDs = quotesIDs {
            return quotesIDs.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
//        guard let characterQuotesDict = characterQuotesDict,
//              let quotesIDs = quotesIDs else {
//            cell.textLabel?.text = "Character has no quotes yet..."
//            return cell
//        }
        
//        cell.textLabel?.text = characterQuotesDict[quotesIDs[indexPath.row].value]
        
        
        guard let quotesIDs = quotesIDs else { return cell }
        
        if let quote = characterQuotesDict![quotesIDs[indexPath.row]] {
            cell.textLabel?.text = quote.text
        } else {
            cell.textLabel?.text = ""
        }
        
        
        
        
//        cell.textLabel?.text = "quote text \(indexPath.row) with id:\(quotesIDs[indexPath.row])"
        return cell

    }
    
}
