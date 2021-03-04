import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak private var charactersTableView: UITableView!
    
    private let model = Core.Characters
    
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
        return model.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = model.characters[indexPath.row].name
        return cell
    }
    
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath
        performSegue(withIdentifier: "showCharacterFromCharacters", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showCharacterFromCharacters") {
            let destinationVC = segue.destination as! CharacterDetailsViewController
            destinationVC.character = model.characters[selectedIndex.row]
        }
    }
    
}
