import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var character: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character {
            print("🟢 character: \(character)")
        }
    }
}
