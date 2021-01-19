import UIKit
import KeychainAccess
import Swinject

class LoginView: UIViewController {

    @IBOutlet private weak var loginPassword: UIStackView!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var verticalLogPassConstraint: NSLayoutConstraint!
    
    private let protocolValidator: FieldValidator = ComplexLogPassFieldValidator()
    
    private let conteinerFieldValidator = Dependency.conteiner.resolve(FieldValidator.self)
    
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
        self.styleScreen()
    }
    
    func styleScreen() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component( .hour , from: date)
        
        if hour <= 18 && hour >= 8 {
            let conteinerStyle = Dependency.conteiner.resolve(LightStyle.self, name: "Light")
            self.view.backgroundColor = conteinerStyle?.bgColor
            self.loginTextField.textColor = conteinerStyle?.textColor
        }else{
            let conteinerStyle = Dependency.conteiner.resolve(DarkStyle.self, name: "Dark")
            self.view.backgroundColor = conteinerStyle?.bgColor
            self.loginTextField.textColor = conteinerStyle?.textColor
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loginTextField.text = UserManager.username
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    private func animateLoginPassword (){
        //MARK:AnimateLoginPasswordCollection
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
        }else {
            UserManager.username = loginTextField.text
            
            let viewControllers = [TabViewController()]
            
            guard let navigationController = self.navigationController else {return}
            navigationController.setViewControllers(viewControllers, animated: false)
        }
    }
}

// MARK: UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if (string == " ") {
                return false
            }
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            loginButton.isEnabled = protocolValidator.checkLoginAndPassword(loginTextField.text!, passwordTextField.text!)
        }
    }

//
//class CustomLoginTextField: UITextField{
//    override func borderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets.init(top: 25, left: 25, bottom: 25, right: 25))
//    }
//}
