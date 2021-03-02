struct AccountManager {
    
    enum AccountManagerError: Error {
        case missingValues
        case accountAlreadyExists
        case wrongPassword
        case accountNotFound
        case passwordDoNotMatch
        case passwordIsToShort
        case noUpperCaseCharacterInPassword
        case noLowerCaseCharacterInPassword
        case noNumericCharacterInPassword
        case noSpecialCharacterInPassword
        
        var errorDescription: String {
            switch self {
            case .missingValues:
                return "Missing required values."
            case .accountAlreadyExists:
                return "This username is already taken."
            case .wrongPassword:
                return "Password is not correct."
            case .accountNotFound:
                return "Account with this username is not found."
            case .passwordDoNotMatch:
                return "Your password and confirmation password do not match."
            case .passwordIsToShort:
                return "Your password must be at least 8 characters."
            case .noUpperCaseCharacterInPassword:
                return "Your password must contain at least one upper case, or capital, letter."
            case .noLowerCaseCharacterInPassword:
                return "Your password must contain at least one lower case letter."
            case .noNumericCharacterInPassword:
                return "Your password must contain at least one number digit."
            case .noSpecialCharacterInPassword:
                return "Your password must contain at least one special character from following: \n$, !, &, ^, %, $, #, @, (, ), /"
            }
        }
    }
    
    static var loggedInAccount: Account? {
        didSet {
            UserDefaultsManager.currentAccount = loggedInAccount
        }
    }
    
    static func login(username: String?, password: String?) throws {
        guard let accounts = UserDefaultsManager.accounts else {
            throw AccountManagerError.accountNotFound
        }
        for account in accounts where account.username == username {
            guard password == UserDefaultsManager.getPassword(username: account.username) else {
                throw AccountManagerError.wrongPassword
            }
            loggedInAccount = account
            return
        }
        throw AccountManagerError.accountNotFound
    }
    
    static func registerAccount(username: String?, password: String?, confirmPassword: String?) throws {
        guard
            let username = username,
            let password = password,
            let confirmPassword = confirmPassword,
            username.isNotEmpty,
            password.isNotEmpty,
            confirmPassword.isNotEmpty
        else {
            throw AccountManagerError.missingValues
        }
        
        guard !isUsernameTaken(username) else {
            throw AccountManagerError.accountAlreadyExists
        }
        
        guard password == confirmPassword else {
            throw AccountManagerError.passwordDoNotMatch
        }
        
        guard password.count >= 8 else {
            throw AccountManagerError.passwordIsToShort
        }
        
        guard password.hasUppercase else {
            throw AccountManagerError.noUpperCaseCharacterInPassword
        }
        
        guard password.hasLowercase else {
            throw AccountManagerError.noLowerCaseCharacterInPassword
        }
        
        guard password.hasNumber else {
            throw AccountManagerError.noNumericCharacterInPassword
        }
        
        
        guard password.hasSpecialCharacter else {
            throw AccountManagerError.noSpecialCharacterInPassword
        }
        
        var account = Account(username: username, password: password, favouriteQuotes: [])
        UserDefaultsManager.saveAccount(&account)
        loggedInAccount = account
    }
    
    private static func isUsernameTaken(_ username: String) -> Bool {
        guard let accounts = UserDefaultsManager.accounts else { return false }
        return accounts.contains { account -> Bool in
            account.username == username
        }
    }
    
}
