import UIKit
import KeychainAccess
import Swinject

protocol ModelView {
    var loginButtonTitle: String { get }
    var loginButtonEnabled: ((Bool)->Void)? {get set}
    var loginField: String? {get}
    var passwordField: String? {get}
    func inputLogin(_ input: String)
    func inputPassword(_ input: String)
    }
    

class LoginModelView: ModelView {
    
    let loginButtonTitle = "qwerty"
    
    private let validator: FieldValidator!
    
    var loginButtonEnabled: ((Bool) -> Void)? {
        didSet{
            self.checkField()
        }
    }

    var loginField: String?
    var passwordField: String?
    
    init(validator: FieldValidator) {
        self.validator = Dependency.container.resolve(FieldValidator.self)
    }
    
    private var login: String = ""{
        didSet{
            self.login = self.loginField!
            self.checkField()
        }
    }
    private var password = "" {
        didSet{
            self.password = self.passwordField!
            self.checkField()
        }
    }
    
    func inputLogin(_ input: String){
        self.login = input
        self.checkField()
    }
    
    func inputPassword(_ input: String){
        self.password = input
        self.checkField()
    }
    
    private func checkField(){
        let valid = self.validator.checkLoginAndPassword(login, password)
        self.loginButtonEnabled!(valid)
        
        }
    }


class LoginVC: UIViewController {

    @IBOutlet private weak var loginPassword: UIStackView!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var verticalLogPassConstraint: NSLayoutConstraint!

    private let containerFieldValidator = Dependency.container.resolve(FieldValidator.self)!
    private let containerStyleLoginVC = Dependency.container.resolve(ProtocolTimerControl.self)!
    private var viewModel = Dependency.container.resolve(ModelView.self)!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
                
        self.loginButton.isEnabled = false
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextField.layer.cornerRadius = 5
        self.loginButton.layer.cornerRadius = 10
        self.animateLoginPassword()
        self.passwordTextField.isSecureTextEntry = true
        self.setStyleLoginVC()
       
        
    }
//MARK: Save Username
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loginTextField.text = UserManager.username

    }
//MARK: Show Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
//MARK: SetStyleLoginVC
    private func setStyleLoginVC(){
        let style = containerStyleLoginVC.setStyle()
        self.view.backgroundColor = style.bgColor
        self.loginTextField.textColor = style.textColor
        self.passwordTextField.textColor = style.textColor
    }
//MARK: AnimateLoginPassword
    private func animateLoginPassword (){
        loginPassword.frame = CGRect(x: verticalLogPassConstraint.constant,
                                      y: self.view.frame.height,
                                      width: 235, height: 36)

        UIView.animate(withDuration: 3, delay: 0, options: [.transitionCurlUp]) {
            self.loginPassword.frame = CGRect(x: self.verticalLogPassConstraint.constant,
                                              y: self.centerConstraint.constant,
                                              width: 235, height: 36)
        } completion: { _ in
            self.loginPassword.didMoveToWindow()
        }
    }
//MARK: LoginToPush
    @IBAction private func loginToPush(_ sender: UIButton) {
        if let _ = Double(loginTextField.text!){
            let alert = UIAlertController(title: "A name cannot be a number",
                                          message: "Enter name",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok",
                                          style: .cancel,
                                          handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
                let boolCheck = AttemptsCountValidator.boolCheck
                if boolCheck == false{
                    let alert = UIAlertController(title: "incorrect password",
                                                  message: "password error",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok",
                                                 style: .cancel,
                                                 handler: nil)
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                    self.loginButton.isEnabled = false
                    AttemptsCountValidator.numberOfAttempts += 1
                    print("Count attempts \(AttemptsCountValidator.numberOfAttempts)")
                }
                UserManager.username = loginTextField.text
                let viewControllers = [TabVC()]
                guard let navigationController = self.navigationController else {return}
                navigationController.setViewControllers(viewControllers, animated: true)
            }
        }
    }
// MARK: UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if (string == " ") {
                return false
            }
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            let boolCheck = containerFieldValidator.checkLoginAndPassword(loginTextField.text!, passwordTextField.text!)
            self.loginButton.isEnabled = boolCheck
        }
    }

