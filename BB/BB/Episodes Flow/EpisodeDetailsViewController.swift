import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak private var episodeDetailsTableView: UITableView!
    
    @IBOutlet weak private var headerContainerView: UIView!
    @IBOutlet weak private var episodeTitleLabel: UILabel!
    @IBOutlet weak private var seasonAndEpisodeNumberLabel: UILabel!
    @IBOutlet weak private var airDateLabel: UILabel!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeDetailsTableView.dataSource = self
        episodeDetailsTableView.tableFooterView = UIView()
        
        if let episode = episode {
            fillContent(for: episode)
        }
        
    }
    
    private func fillContent(for episode: Episode) {
        episodeTitleLabel.text = episode.title
        let seasonNumberText = "Season \(episode.seasonNumber), "
        let episodeNumberText = "Episode \(episode.episodeNumber)"
        seasonAndEpisodeNumberLabel.text = seasonNumberText + episodeNumberText
        airDateLabel.text = episode.airDate
    }
    
}

extension EpisodeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let episode = episode {
            return episode.characters.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let episode = episode  else { return cell }
        
        cell.textLabel?.text = episode.characters[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Characters"
    }
    
}
