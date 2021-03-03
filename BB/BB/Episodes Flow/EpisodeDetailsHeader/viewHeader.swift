import UIKit

class ViewHeader: UIView {
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var seasonAndEpisodeNumberLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    
    func fillContent(for episode: Episode) {
        episodeTitleLabel.text = episode.title
        
        let seasonNumberText = "Season \(episode.seasonNumber), "
        let episodeNumberText = "Episode \(episode.episodeNumber)"

        seasonAndEpisodeNumberLabel.text = seasonNumberText + episodeNumberText
    }

}
