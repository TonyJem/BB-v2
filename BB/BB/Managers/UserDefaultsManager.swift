import Foundation

struct UserDefaultsManager {
    
    private enum UserDefaultsManagerKey {
        static let accounts = "Accounts"
        static let loggedInAccount = "loggedInAccount"
        static let likedQuotes = "LikedQuotes"
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    private static var keyChain: KeychainSwift {
        KeychainSwift()
    }
    
    static func saveAccount(_ account: inout Account) {
        var savedAccounts = [Account]()
        
        if let accounts = accounts {
            savedAccounts = accounts
        }
        savePassword(account.password, username: account.username)
        account.password = ""
        savedAccounts.append(account)
        accounts = savedAccounts
    }
    
    static func save(favoriteQuotes: [Quote], to account: Account) {
        var savedAccounts = [Account]()
        if let accounts = accounts {
            savedAccounts = accounts
            
            if let index = accounts.firstIndex(where: { $0.username == account.username }) {
                savedAccounts[index].favouriteQuotes = favoriteQuotes
            }
        }
        accounts = savedAccounts
    }
    
    static func saveLikedQuotes() {
        likedQuotes = Core.quoteModel.allLikedQuotes
    }
}

// MARK: - Helpers

extension UserDefaultsManager {
    
    static var accounts: [Account]? {
        get {
            guard let encodedAccounts = userDefaults.object(forKey: UserDefaultsManagerKey.accounts) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([Account].self, from: encodedAccounts)
        } set {
            let encodedAccounts = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedAccounts, forKey: UserDefaultsManagerKey.accounts)
        }
    }
    
    static var currentAccount: Account? {
        get {
            guard let currentAccount = userDefaults.object(forKey: UserDefaultsManagerKey.loggedInAccount) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(Account.self, from: currentAccount)
        } set {
            let currentAccount = try? JSONEncoder().encode(newValue)
            userDefaults.set(currentAccount, forKey: UserDefaultsManagerKey.loggedInAccount)
        }
    }
    
    static var likedQuotes: [likedQuote]? {
        get {
            guard let encodedLikedQuotes = userDefaults.object(forKey: UserDefaultsManagerKey.likedQuotes) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([likedQuote].self, from: encodedLikedQuotes)
        } set {
            let encodedLikedQuotes = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedLikedQuotes, forKey: UserDefaultsManagerKey.likedQuotes)
        }
    }
    
}

// MARK: - keyChain methods

extension UserDefaultsManager {
    
    private static func savePassword(_ password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    static func getPassword(username: String) -> String? {
        keyChain.get(username)
    }
    
}
