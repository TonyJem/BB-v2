import UIKit

class EpisodesViewController: MainViewController {
    
    @IBOutlet private var seasonsTableView: UITableView!
    
    private let model = Core.Seasons
    
    var selectedIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonsTableView.register(UINib(nibName: String(describing: EpisodeTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: EpisodeTableViewCell.self))
        
        seasonsTableView.delegate = self
        seasonsTableView.dataSource = self
        seasonsTableView.tableFooterView = UIView()
    }
    
    @IBAction func filterButtonTap(_ sender: UIBarButtonItem) {
        print("🟢 Filter button is tapped")
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

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndex = indexPath
        performSegue(withIdentifier: "showEpisodeDetailView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "showEpisodeDetailView") {
                let destinationVC = segue.destination as! EpisodeDetailsViewController
                destinationVC.episodeID = 15
            }
        }
}
