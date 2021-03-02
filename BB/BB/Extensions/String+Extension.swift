import Foundation

extension String {
    struct Constants {
        static let uppercaseCharactersRegEx = ".*[A-Z]+.*"
        static let lowercaseCharactersRegEx = ".*[a-z]+.*"
        static let numberRegEx = ".*[0-9]+.*"
        static let specialCharactersRegEx = ".*[!&^%$#@()/]+.*"
    }

    var isNotEmpty: Bool {
        !isEmpty
    }
    
    var hasUppercase: Bool {
        let testText = NSPredicate(format: "SELF MATCHES %@", Constants.uppercaseCharactersRegEx)
        return testText.evaluate(with: self)
    }
    
    var hasLowercase: Bool {
        let testText = NSPredicate(format: "SELF MATCHES %@", Constants.lowercaseCharactersRegEx)
        return testText.evaluate(with: self)
    }
    
    var hasNumber: Bool {
        let testText = NSPredicate(format: "SELF MATCHES %@", Constants.numberRegEx)
        return testText.evaluate(with: self)
    }
    
    var hasSpecialCharacter: Bool {
        let testText = NSPredicate(format: "SELF MATCHES %@", Constants.specialCharactersRegEx)
        return testText.evaluate(with: self)
    }
    
}
