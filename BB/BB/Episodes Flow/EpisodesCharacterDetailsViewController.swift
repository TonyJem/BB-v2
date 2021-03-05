import UIKit

class EpisodesCharacterDetailsViewController: UIViewController {
    
    @IBOutlet var characterDetailsContainerView: CharacterDetailsView!
    var characters: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterDetailsContainerView.quotesTableView.dataSource = self
    }
    
}

extension EpisodesCharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "TestTextForQuoteTable"
        return cell
    }
    
}
