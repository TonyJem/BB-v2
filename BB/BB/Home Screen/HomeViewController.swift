import UIKit

class HomeViewController: MainViewController {
    
    @IBOutlet private weak var appTitleLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var episodesButton: UIButton!
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var quotesButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    private let apiManager = Core.apiManager
    private let seasonModel = Core.seasonModel
    private let characterModel = Core.characterModel
    private let quotesModel = Core.quoteModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let loggedInAccount = AccountManager.loggedInAccount else { return }
        usernameLabel.text = loggedInAccount.username
//        TODO: switched off for test reasons
//        quotesButton.isEnabled = !loggedInAccount.favouriteQuotes.isEmpty
        
    }
    
    @IBAction private func episodesButtonTapped(_ sender: UIButton) {
        print("🟢 episodesButtonDidTap")
        fetchEpisodesToModel()
    }
    
    @IBAction private func charactersButtonTapped(_ sender: UIButton) {
        print("🟢 charactersButtonDidTap")
        
        if characterModel.characters.isEmpty {
            fetchCharactersToModel()
        } else {
            print("🟡 Skip fething Characters from API and load quotes from model")
            proceedToCharactersScene()
        }

    }
    
    @IBAction private func quotesButtonTapped(_ sender: UIButton) {
        print("🟢 quotesButtonDidTap")
        
        if quotesModel.quotes.isEmpty {
            print("🟣 Start fething quotes from API")
            fetchQuotesToModel()
        } else {
            print("🟡 Skip fething quotes from API and laod quotes from model")
            quotesModel.generateRandomQuote()
            proceedToQuotesScene()
        }
        
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
                self.proceedToEpisodesScene()
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
    private func fetchCharactersToModel() {
        apiManager.getCharacters { result in
            switch result {
            case .success(let characters):
                self.characterModel.characters = characters
                self.proceedToCharactersScene()
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
    private func fetchQuotesToModel() {
        apiManager.getQuotes { result in
            switch result {
            case .success(let quotes):
                print("🟢 All Quotes did fetch Ok!")
                self.quotesModel.quotes = quotes
                self.quotesModel.generateRandomQuote()
                self.proceedToQuotesScene()
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
}
