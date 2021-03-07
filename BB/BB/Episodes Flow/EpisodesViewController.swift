import UIKit

class EpisodesViewController: MainViewController {
    
    @IBOutlet private weak var seasonsTableView: UITableView!
    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let seasonModel = Core.seasonModel
    private let apiManager = Core.apiManager
    private let characterModel = Core.characterModel
    
    private var selectedIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = true
        
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
        return seasonModel.seasonNumbers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < seasonModel.seasonNumbers.count {
            return "Section \(seasonModel.seasonNumbers[section])"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonModel.seasonBy(seasonNumber: String(section + 1)).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = seasonsTableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeTableViewCell.self), for: indexPath) as? EpisodeTableViewCell else { return UITableViewCell() }
        let seasonNumber = seasonModel.seasonNumbers[indexPath.section]
        let season = seasonModel.seasonBy(seasonNumber: seasonNumber)
        let episode = season[indexPath.row]
        cell.fillContent(selectedEpisode: episode)
        return cell
    }
    
}

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndex = indexPath
        self.characterModel.characters.isEmpty ? fetchCharactersAndPerformSegue() : performSegue()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "showEpisodeDetailView") {
                let destinationVC = segue.destination as! EpisodeDetailsViewController
                
                let seasonNumber = seasonModel.seasonNumbers[selectedIndex.section]
                let season = seasonModel.seasonBy(seasonNumber: seasonNumber)
                let episode = season[selectedIndex.row]
                
                destinationVC.episode = episode
            }
        }
    
    private func performSegue() {
        performSegue(withIdentifier: "showEpisodeDetailView", sender: nil)
    }
    
    private func fetchCharactersAndPerformSegue() {
        turnActivityIndicatorON()
        apiManager.getCharacters { result in
            switch result {
            case .success(let characters):
                self.characterModel.characters = characters
                self.turnActivityIndicatorOFF()
                self.performSegue()
            case .failure(let error):
                print("🔴 \(error)")
                self.turnActivityIndicatorOFF()
            }
        }
    }
    
    private func turnActivityIndicatorON() {
        indicatorView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func turnActivityIndicatorOFF() {
        indicatorView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}
