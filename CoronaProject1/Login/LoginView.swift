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
    
    private let containerFieldValidator = Dependency.container.resolve(FieldValidator.self)
    private let containerStyleLoginVC = Dependency.container.resolve(ProtocolTimerControl.self)
    
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
        self.containerStyleLoginVC?.setStyle(loginTextField, view)

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
            if containerFieldValidator?.passwordValidator(passwordTextField.text!) != true{
                let alert = UIAlertController(title: "incorrect password",
                                              message: "incorrect password",
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok",
                                              style: .cancel,
                                              handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }else{
                UserManager.username = loginTextField.text
                let viewControllers = [TabViewController()]
                guard let navigationController = self.navigationController else {return}
                navigationController.setViewControllers(viewControllers, animated: true)
            }
            
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
            let boolCheck = containerFieldValidator?.checkLoginAndPassword(loginTextField.text!, passwordTextField.text!)
            loginButton.isEnabled = boolCheck!
        }
    }

