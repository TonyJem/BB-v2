import UIKit

class MainViewController: UIViewController {
    
// MARK: - Storyboards
    
    private lazy var HomeStoryboard: UIStoryboard = {
        UIStoryboard(name: "Home", bundle: nil)
    }()
    
    private lazy var EpisodesStoryboard: UIStoryboard = {
        UIStoryboard(name: "Episodes", bundle: nil)
    }()
    
    private lazy var CharactersStoryboard: UIStoryboard = {
        UIStoryboard(name: "Characters", bundle: nil)
    }()
    
    private lazy var QuotesStoryboard: UIStoryboard = {
        UIStoryboard(name: "Quotes", bundle: nil)
    }()
    
// MARK: - Controllers
    
    private var HomeViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "HomeViewController")
    }

    private var EpisodesNavigationController: UINavigationController {
        EpisodesStoryboard.instantiateViewController(identifier: "Episodes")
    }
    
    //    TODO: Kol kas nenaudojamas
    private var EpisodeDetailsViewController: UIViewController {
        EpisodesStoryboard.instantiateViewController(identifier: "EpisodeDetailsVC")
    }
    
    private var CharactersNavigationController: UINavigationController {
        CharactersStoryboard.instantiateViewController(identifier: "Characters")
    }
    
    private var QuotesNavigationController: UINavigationController {
        QuotesStoryboard.instantiateViewController(identifier: "Quotes")
    }
    
}

// MARK: - Transitions

extension MainViewController {
    
    func proceedToHomeView() {
        modalPresentationStyle = .fullScreen
        present(HomeViewController, animated: true)
    }
    
    func proceedToEpisodesScene() {
        modalPresentationStyle = .fullScreen
        present(EpisodesNavigationController, animated: true)
    }
    
//    TODO: Kol kas nenaudojamas
    func proceedToEpisodesDetails() {
        modalPresentationStyle = .fullScreen
        present(EpisodeDetailsViewController, animated: true)
    }
    
    func proceedToCharactersScene() {
        modalPresentationStyle = .fullScreen
        present(CharactersNavigationController, animated: true)
    }
    
    func proceedToQuotesScene() {
        modalPresentationStyle = .fullScreen
        present(QuotesNavigationController, animated: true)
    }
    
}
