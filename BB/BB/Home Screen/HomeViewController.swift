import UIKit

class HomeViewController: MainViewController {
    
    @IBOutlet private weak var appTitleLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var episodesButton: UIButton!
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var quotesButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    private let apiManager = Core.ApiManager
    private let model = Core.Seasons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let loggedInAccount = AccountManager.loggedInAccount else { return }
        usernameLabel.text = loggedInAccount.username
        quotesButton.isEnabled = !loggedInAccount.favouriteQuotes.isEmpty
        
    }
    
    @IBAction private func episodesButtonTapped(_ sender: UIButton) {
        print("🟢 episodesButtonDidTap")
        fetchEpisodesToModel()
    }
    
    @IBAction private func charactersButtonTapped(_ sender: UIButton) {
        print("🟢 charactersButtonDidTap")
        
        apiManager.getCharacters { result in
            switch result {
            case .success(let episodes):
//   TODO: Add real functionality here
                print("🟢  Episodes didFetch: \(episodes)" )
            case .failure(let error):
                print("🔴 \(error)")
            }
        }

    }
    
    @IBAction private func quotesButtonTapped(_ sender: UIButton) {
        print("🟢 quotesButtonDidTap")
    }
    
    @IBAction private func logoutButtonTapped(_ sender: UIButton) {
        AccountManager.loggedInAccount = nil
        dismiss(animated: true)
    }
    
    private func fetchEpisodesToModel() {
        apiManager.getEpisodes { result in
            switch result {
            case .success(let episodes):
                self.model.episodes = episodes
                self.proceedEpisodesScene()
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
}
