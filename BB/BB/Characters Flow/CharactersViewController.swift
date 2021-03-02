import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak private var charactersTableView: UITableView!
    
    private let model = Core.Characters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersTableView.dataSource = self
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
