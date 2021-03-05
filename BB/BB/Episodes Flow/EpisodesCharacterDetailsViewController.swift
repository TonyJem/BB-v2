import UIKit

class EpisodesCharacterDetailsViewController: UIViewController {
    
    @IBOutlet var characterDetailsContainerView: CharacterDetailsView!
    
    var characterName: String?
    
    private var character: Character?
    private var chracterModel = Core.characterModel
    private var quoteModel = Core.quoteModel
    private var characterQuotes: [Quote]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsContainerView.quotesTableView.dataSource = self
        
        guard let characterName = characterName else { return }
        
        guard let character = chracterModel.getCharacter(by: characterName) else { return }
        characterDetailsContainerView.nameLabelText = character.name
        characterDetailsContainerView.birthdayLabelText = character.birthday
        
        print("🟢 all Quotes: \(quoteModel.quotes)")
        
        characterQuotes = quoteModel.getQuotes(for: character)
        print("🟢🟢🟢 \(String(describing: characterQuotes))")
    }
    
}

extension EpisodesCharacterDetailsViewController: UITableViewDataSource {
    
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
