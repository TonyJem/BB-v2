import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    var episodeID = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if episodeID == 15 {
            print("🟢 Data reiceived")
        } else {
            print("🔴 No data apeared")
        }
        
    }
}
