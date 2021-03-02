import UIKit

class EpisodesViewController: UIViewController {

    @IBOutlet private var seasonsTableView: UITableView!
    
    private let model = Core.Seasons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonsTableView.dataSource = self
        seasonsTableView.tableFooterView = UIView()
    }
    
    @IBAction func filterButtonIsTapped(_ sender: UIBarButtonItem) {
        print("🟢 Filter button is tapped")
    }
    
}

extension EpisodesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        print(model.seasonNumbers.count)
        return model.seasonNumbers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < model.seasonNumbers.count {
            return "Section \(model.seasonNumbers[section])"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.seasonBy(seasonNumber: String(section + 1)).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let seasonNumber = model.seasonNumbers[indexPath.section]
        let season = model.seasonBy(seasonNumber: seasonNumber)
        let episode = season[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
}
