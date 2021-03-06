import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    @IBOutlet private weak var episodeNumberTitle: UILabel!
    
    func fillContent(selectedEpisode: Episode) {
        episodeTitleLabel.text = selectedEpisode.title
        episodeNumberTitle.text = "episode \(selectedEpisode.episodeNumber)"
    }
    
}
