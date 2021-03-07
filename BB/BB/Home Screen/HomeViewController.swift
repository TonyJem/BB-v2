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
        
        setupUI()
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
    
}

private extension HomeViewController {
    
    func setupUI() {
        indicatorView.isHidden = true
        guard let loggedInAccount = AccountManager.loggedInAccount else { return }
        usernameLabel.text = loggedInAccount.username
        
        episodesButton.layer.cornerRadius = episodesButton.frame.size.height/2
        charactersButton.layer.cornerRadius = episodesButton.frame.size.height/2
        quotesButton.layer.cornerRadius = episodesButton.frame.size.height/2
        
        
        //        TODO: switched off for test reasons
        //        BUG: Button does not know if user added favourites... Might is necessary to add Observer.
        //        quotesButton.isEnabled = !loggedInAccount.favouriteQuotes.isEmpty
    }
    
    func fetchEpisodesToModel() {
        self.turnActivityIndicatorON()
        apiManager.getEpisodes { result in
            switch result {
            case .success(let episodes):
                self.seasonModel.episodes = episodes
                self.turnActivityIndicatorOFF()
                self.proceedToEpisodesScene()
            case .failure(let error):
                self.turnActivityIndicatorOFF()
                print("🔴 \(error)")
            }
        }
    }
    
    func fetchCharactersToModel() {
        self.turnActivityIndicatorON()
        apiManager.getCharacters { result in
            switch result {
            case .success(let characters):
                self.characterModel.characters = characters
                self.turnActivityIndicatorOFF()
                self.proceedToCharactersScene()
            case .failure(let error):
                self.turnActivityIndicatorOFF()
                print("🔴 \(error)")
            }
        }
    }
    
    func fetchQuotesToModel() {
        self.turnActivityIndicatorON()
        apiManager.getQuotes { result in
            switch result {
            case .success(let quotes):
                print("🟢 All Quotes did fetch Ok!")
                self.quotesModel.quotes = quotes
                self.quotesModel.generateRandomQuote()
                self.turnActivityIndicatorOFF()
                self.proceedToQuotesScene()
            case .failure(let error):
                self.turnActivityIndicatorOFF()
                print("🔴 \(error)")
            }
        }
    }
    
    func turnActivityIndicatorON() {
        indicatorView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func turnActivityIndicatorOFF() {
        indicatorView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}
