import UIKit

class HomeViewController: MainViewController {
    
    @IBOutlet private weak var appTitleLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var episodesButton: UIButton!
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var quotesButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    private let apiManager = Core.ApiManager
    private let seasonModel = Core.Seasons
    private let characterModel = Core.Characters

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
        fetchCharactersToModel()
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
                self.seasonModel.episodes = episodes
                self.proceedEpisodesScene()
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
    private func fetchCharactersToModel() {
        apiManager.getCharacters { result in
            switch result {
            case .success(let characters):
                print("🟢  Characters didFetch: \(characters)" )
                self.characterModel.characters = characters
                
                print("🟢 Count:")
                print(self.characterModel.characters.count)
                
                print("🟢 1st item print:")
                print(self.characterModel.characters[0].name)
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
}
