import UIKit

class LoginViewController: MainViewController {
    private enum Flow {
        case login
        case register
    }
    
    @IBOutlet private weak var appTitleLabel: UILabel!
    @IBOutlet private weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    private var selectedFlow: Flow = .login {
        didSet {
            confirmPasswordTextField.isHidden = selectedFlow == .login
        }
    }
    
    private var loginFlowTextfields: [UITextField] = []
    private var registerFlowTextfields: [UITextField] = []
    private var shownTextfields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        guard let savedAccount = UserDefaultsManager.currentAccount else { return }
        AccountManager.loggedInAccount = savedAccount
        print("🟢 Account is: \(savedAccount.username)")
        proceedToHomeView()
    }
    
    @objc func textChanged(_ textField: UITextField) {
        shownTextfields = confirmPasswordTextField.isHidden ? loginFlowTextfields : registerFlowTextfields
        submitButton.isEnabled = !shownTextfields.contains { $0.text!.isEmpty }
    }
    
    @IBAction private func loginSegmentedControlChanged(_ sender: UISegmentedControl) {
        selectedFlow = sender.selectedSegmentIndex == 0 ? .login : .register
        clearTextFields(withPasswordsOnly: true)
        submitButton.isEnabled = false
    }
    
    @IBAction private func submitButtonTapped(_ sender: UIButton) {
        
        switch selectedFlow {
        case .login:
            print("🟢 Proceed Login Flow")
            do {
                try AccountManager.login(username: usernameTextField.text, password: passwordTextField.text)
                print("🟢🟢 No Errors in Login Flow")
                proceedToHomeView()
                clearTextFields()
// TODO: Need to ask: kodel "becomeFirstResponder" neSuveikia ? bent kursorius mirksi paskutiniame pildytame textFielde:
                usernameTextField.becomeFirstResponder()
                
            } catch {
                if let error = error as? AccountManager.AccountManagerError {
                    callAlert(with: error.errorDescription)
                }
            }
        case .register:
            print("🟢 Proceed Register Flow")
            do {
                try AccountManager.registerAccount(username: usernameTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text)
                print("🟢🟢 No Errors in Register Flow")
                proceedToHomeView()
                clearTextFields()
                loginSegmentedControl.selectedSegmentIndex = 0
                confirmPasswordTextField.isHidden = true
                selectedFlow = .login
            } catch {
                if let error = error as? AccountManager.AccountManagerError {
                    callAlert(with: error.errorDescription)
                }
            }
        }
    }
}

private extension LoginViewController {
    
    func setupControls() {
        loginSegmentedControl.selectedSegmentIndex = 0
        confirmPasswordTextField.isHidden = true
        submitButton.isEnabled = false
        
        usernameTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        loginFlowTextfields = [usernameTextField, passwordTextField]
        registerFlowTextfields = [usernameTextField, passwordTextField, confirmPasswordTextField]
    }
    
    func clearTextFields(withPasswordsOnly: Bool = false) {
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        usernameTextField.text = withPasswordsOnly ? usernameTextField.text : ""
    }
    
    func callAlert(with errorMessage: String) {
        let titleForFlow = selectedFlow == .login ? "Login is not possible!" : "Register is not possible!"
        let alert = UIAlertController(title: titleForFlow, message: errorMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
