import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak private var charactersTableView: UITableView!
    
    private let characterModel = Core.characterModel
    private let quotesModel = Core.quoteModel
    private let apiManager = Core.apiManager
    
    private var selectedIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.tableFooterView = UIView()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        print("🟢 Filter button in characters did tap")
    }
    
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = characterModel.characters[indexPath.row].name
        return cell
    }
    
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath
        self.quotesModel.quotes.isEmpty ? fetchQuotesAndPerformSegue() : performSegue()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showCharacterFromCharacters") {
            let destinationVC = segue.destination as! CharacterDetailsViewController
            destinationVC.character = characterModel.characters[selectedIndex.row]
        }
    }
    
    private func performSegue() {
        performSegue(withIdentifier: "showCharacterFromCharacters", sender: nil)
    }
    
    private func fetchQuotesAndPerformSegue() {
        apiManager.getQuotes { result in
            switch result {
            case .success(let quotes):
                print("🟢 All Quotes did fetch Ok!")
                self.quotesModel.quotes = quotes
                self.performSegue()
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
}
