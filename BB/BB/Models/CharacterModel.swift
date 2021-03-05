import Foundation

class CharacterModel {
    var characters = [Character]()
    
    func getCharacter(by name: String) -> Character? {
        let filteredCharacters = characters.filter { character in
            return character.name == name
        }
        
        if let character = filteredCharacters.first {
            return character
        } else {
            return nil
        }
    }
    
}
