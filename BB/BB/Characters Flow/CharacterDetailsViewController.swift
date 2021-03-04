import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak private var characterDetailsContainerView: CharacterDetailsView!
    
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character {
            characterDetailsContainerView.nameLabelText = character.name
            characterDetailsContainerView.birthdayLabelText = character.birthday
        }
    }
    
}
