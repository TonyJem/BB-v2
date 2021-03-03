import UIKit

class EpisodeDetailsViewController: UIViewController {

    @IBOutlet weak private var episodeDetailsTableView: UITableView!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeDetailsTableView.dataSource = self
        episodeDetailsTableView.tableFooterView = UIView()
        
        guard let episode = episode else {
            
            print("🔴 Somethig went wrong with getting episode")
            return
        }
        
        let title = episode.title
        let seasonNumber = episode.seasonNumber
        let episodeNumber = episode.episodeNumber
        let airDate = episode.airDate
        let characters = episode.characters
        
        print("🟢 title \(title)")
        print("🟢 seasonNumber \(seasonNumber)")
        print("🟢 episodeNumber \(episodeNumber)")
        print("🟢 airDate \(airDate)")
        print("🟢 1st chracter from characters: \(characters[0])")
        
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
