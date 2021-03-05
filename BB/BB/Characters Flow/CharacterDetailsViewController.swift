import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?
    private var modelQuotes = Core.Quotes
    private var characterQuotes: [Quote]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsContainerView.quotesTableView.dataSource = self
        
        guard let character = character else { return }
        characterDetailsContainerView.nameLabelText = character.name
        characterDetailsContainerView.birthdayLabelText = character.birthday
        
        print("🟢 all Quotes: \(modelQuotes.quotes)")
        
        characterQuotes = modelQuotes.getQuotes(for: character)
        print("🟢🟢🟢 \(String(describing: characterQuotes))")
    }
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let characterQuotes = characterQuotes {
            return characterQuotes.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let characterQuotes = characterQuotes {
            cell.textLabel?.text = characterQuotes[indexPath.row].text
        } else {
            cell.textLabel?.text = "Character has no quotes yet..."
        }
        return cell
    }
    
}
