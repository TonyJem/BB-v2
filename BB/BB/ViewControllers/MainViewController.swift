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
    
// MARK: - Controllers
    
    private var HomeViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "HomeViewController")
    }

    private var EpisodesNavigationController: UINavigationController {
        EpisodesStoryboard.instantiateViewController(identifier: "Episodes")
    }
    
    private var CharactersNavigationController: UINavigationController {
        CharactersStoryboard.instantiateViewController(identifier: "Characters")
    }
    
    private var EpisodeDetailsViewController: UIViewController {
        EpisodesStoryboard.instantiateViewController(identifier: "EpisodeDetailsVC")
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
    
    func proceedToEpisodesDetails() {
        modalPresentationStyle = .fullScreen
        present(EpisodeDetailsViewController, animated: true)
    }
    
    func proceedToCharactersScene() {
        modalPresentationStyle = .fullScreen
        present(CharactersNavigationController, animated: true)
    }
    
    
    
//    EpisodeDetails
    
}
