import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak private var episodeDetailsTableView: UITableView!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeDetailsTableView.register(UINib(nibName: String(describing: EpisodeDetailsHeader.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: EpisodeDetailsHeader.self))
        
        episodeDetailsTableView.dataSource = self
        episodeDetailsTableView.tableFooterView = UIView()
        
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeDetailsHeader") as! EpisodeDetailsHeader
        
        guard let episode = episode else { return headerView }
        headerCell.fillContent(for: episode)
        headerView.addSubview(headerCell)
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Characters"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 200
        }
    
}
/*
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "customTableCell") as! CustomTableCell
        headerView.addSubview(headerCell)
        return headerView
    }
*/
