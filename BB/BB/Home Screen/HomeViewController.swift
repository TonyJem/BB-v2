import UIKit

class HomeViewController: MainViewController {
    
    @IBOutlet private weak var appTitleLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var episodesButton: UIButton!
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var quotesButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    @IBOutlet weak private var indicatorView: UIView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private let apiManager = Core.apiManager
    private let seasonModel = Core.seasonModel
    private let characterModel = Core.characterModel
    private let quotesModel = Core.quoteModel

    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = true
        
        guard let loggedInAccount = AccountManager.loggedInAccount else { return }
        usernameLabel.text = loggedInAccount.username
//        TODO: switched off for test reasons
//        BUG: Button does not know if user added favourites... Might is necessary to add Observer.
//        quotesButton.isEnabled = !loggedInAccount.favouriteQuotes.isEmpty
        
    }
    
    @IBAction private func episodesButtonTapped(_ sender: UIButton) {
        print("🟢 episodesButtonDidTap")
        
        if seasonModel.episodes.isEmpty {
            fetchEpisodesToModel()
        } else {
            print("🟡 Skip fething Episodes from API and load them from model")
            proceedToEpisodesScene()
        }
        
    }
    
    @IBAction private func charactersButtonTapped(_ sender: UIButton) {
        print("🟢 charactersButtonDidTap")
        
        if characterModel.characters.isEmpty {
            fetchCharactersToModel()
        } else {
            print("🟡 Skip fething Characters from API and load them from model")
            proceedToCharactersScene()
        }

    }
    
    @IBAction private func quotesButtonTapped(_ sender: UIButton) {
        print("🟢 quotesButtonDidTap")
        
        if quotesModel.quotes.isEmpty {
            print("🟣 Start fething Quotes from API")
            indicatorView.isHidden = false
            activityIndicator.startAnimating()
            
            fetchQuotesToModel()
        } else {
            print("🟡 Skip fething Quotes from API and laod quotes from model")
            quotesModel.generateRandomQuote()
            proceedToQuotesScene()
        }
        
    }
    
    @IBAction private func logoutButtonTapped(_ sender: UIButton) {
        
        if let currentAccount = UserDefaultsManager.currentAccount {
            UserDefaultsManager.save(favoriteQuotes: quotesModel.favoriteQuotes, to: currentAccount)
        }
        
        UserDefaultsManager.saveLikedQuotes()
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
                self.indicatorView.isHidden = true
                self.activityIndicator.stopAnimating()
                self.quotesModel.quotes = quotes
                self.quotesModel.generateRandomQuote()
                self.proceedToQuotesScene()
            case .failure(let error):
                self.indicatorView.isHidden = true
                self.activityIndicator.stopAnimating()
                print("🔴 \(error)")
            }
        }
    }
    
}
