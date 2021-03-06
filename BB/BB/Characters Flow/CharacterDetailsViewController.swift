import UIKit

class CharacterDetailsViewController: UIViewController {
//    TODO: Move same functionality from CharacterDetailsViewController and  EpisodesCharacterDetailsViewController to same parent class and inherit from here
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?
    
    private var quoteModel = Core.quoteModel
    private var characterQuotes: [Quote]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsContainerView.quotesTableView.dataSource = self
        characterDetailsContainerView.quotesTableView.delegate = self
        characterDetailsContainerView.quotesTableView.tableFooterView = UIView()
        characterDetailsContainerView.quotesTableView.register(UINib(nibName: String(describing: quoteCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: quoteCell.self))
        
        
        guard let character = character else { return }
        characterDetailsContainerView.nameLabelText = character.name
        characterDetailsContainerView.birthdayLabelText = character.birthday

        characterQuotes = quoteModel.getQuotes(for: character)
        
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
        
        guard let cell = characterDetailsContainerView.quotesTableView.dequeueReusableCell(withIdentifier: String(describing: quoteCell.self), for: indexPath) as? quoteCell else { return UITableViewCell() }
        
        if let characterQuotes = characterQuotes {
            cell.fillContent(with: characterQuotes[indexPath.row])
        }
        return cell
    }
    
}

extension CharacterDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let characterQuotes = characterQuotes {
            quoteModel.didSelect(quote: characterQuotes[indexPath.row])
        }
        
        tableView.reloadData()
    }
    
}
