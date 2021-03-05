import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?
    private var model = Core.Quotes
    private var characterQuotes: [Quote]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsContainerView.quotesTableView.dataSource = self
        
        guard let character = character else { return }
        characterDetailsContainerView.nameLabelText = character.name
        characterDetailsContainerView.birthdayLabelText = character.birthday
        characterQuotes = model.getQuotes(for: character)
        print("🟢🟢🟢 \(String(describing: characterQuotes))")
    }
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let characterQuotes = characterQuotes else { return 1 }
//        return 2
        return characterQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
//        if let characterQuotes = characterQuotes {
//            cell.textLabel?.text = characterQuotes[indexPath.row].text
//        } else {
//            cell.textLabel?.text = "Character has no quotes yet..."
//        }
        cell.textLabel?.text = "🟢 TestCellText"
        return cell
    }
    
}
