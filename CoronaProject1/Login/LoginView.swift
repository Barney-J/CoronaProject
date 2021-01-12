import UIKit
import KeychainAccess

class LoginView: UIViewController {

    @IBOutlet weak var loginPassword: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalLogPassConstraint: NSLayoutConstraint!
    
    let loginFieldValidation = LoginFieldValidation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
                
        loginButton.isEnabled = false
        
        loginTextField.delegate = self
        passwordTextField.delegate = self

        loginTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
        
        passwordTextField.isSecureTextEntry = true
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loginTextField.text = UserManager.username
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
//MARK: LoginToPush
    @IBAction func loginToPush(_ sender: UIButton) {
                
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
            navigationController.setViewControllers(viewControllers, animated: true)
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
            if (loginFieldValidation.checkLoginAndPassword( _loginText: loginTextField.text!, _passwordText: passwordTextField.text!)),
               loginFieldValidation.checkLoginCount( _loginText: loginTextField.text!, _passwordText: passwordTextField.text!){
                loginButton.isEnabled = true
            }else{
                loginButton.isEnabled = false
            }
        }
    }
