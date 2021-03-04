import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character {
            print("🟢 character: \(character)")
            characterDetailsContainerView.nameLabelText = character
            characterDetailsContainerView.birthdayLabelText = "Test Birthday"
        }
    }
    
}
