import UIKit

class EpisodesViewController: MainViewController {

    @IBOutlet private var seasonsTableView: UITableView!
    
    private let model = Core.Seasons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonsTableView.register(UINib(nibName: String(describing: EpisodeTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: EpisodeTableViewCell.self))
        
        seasonsTableView.dataSource = self
        seasonsTableView.tableFooterView = UIView()
    }
    
    @IBAction func filterButtonTap(_ sender: UIBarButtonItem) {
        print("🟢 Filter button is tapped")
        proceedToEpisodesDetails()
    }
    
}

extension EpisodesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
        
        guard let cell = seasonsTableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeTableViewCell.self), for: indexPath) as? EpisodeTableViewCell else { return UITableViewCell() }
        let seasonNumber = model.seasonNumbers[indexPath.section]
        let season = model.seasonBy(seasonNumber: seasonNumber)
        let episode = season[indexPath.row]
        cell.fillContent(selectedEpisode: episode)
        return cell
    }
}
