import UIKit

class MainViewController: UIViewController {
    
// MARK: - Storyboards
    
    private lazy var HomeStoryboard: UIStoryboard = {
        UIStoryboard(name: "Home", bundle: nil)
    }()
    
    private lazy var EpisodesStoryboard: UIStoryboard = {
        UIStoryboard(name: "Episodes", bundle: nil)
    }()
    
// MARK: - Controllers
    
    private var HomeViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "HomeViewController")
    }

    private var EpisodesNavigationController: UINavigationController {
        EpisodesStoryboard.instantiateViewController(identifier: "Episodes")
    }
    
}

// MARK: - Transitions

extension MainViewController {
    
    func proceedToHomeView() {
        modalPresentationStyle = .fullScreen
        present(HomeViewController, animated: true)
    }
    
    func proceedEpisodesScene() {
        modalPresentationStyle = .fullScreen
        present(EpisodesNavigationController, animated: true)
    }
    
}
