import UIKit
import KeychainAccess

class LoginView: UIViewController {

    @IBOutlet weak var loginPassword: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychain = Keychain(service: "com.example.github-token")

        DispatchQueue.global().async {
            do {
                // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                try keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .set("01234567-89ab-cdef-0123-456789abcdef", key: "kishikawakatsumi")
                
                //let value = try keychain.get("kishikawakatsumi")
               // print(value)
            } catch let error {
                print(error)
            }
        }
        
        
        DispatchQueue.global().async {
            do {
                let password = try keychain
                    .authenticationPrompt("Authenticate to login to server")
                    .get("kishikawakatsumi")

                print("password: \(password)")
            } catch let error {
                print(error)
            }
        }

        self.navigationController?.isNavigationBarHidden = true
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        loginTextField.backgroundColor = loginButton.backgroundColor
        passwordTextField.backgroundColor = loginButton.backgroundColor
        
        loginTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
        
        passwordTextField.isSecureTextEntry = true

        
        loginPassword.frame = CGRect(x: 238,
                                      y: self.view.frame.height,
                                      width: 235, height: 36)

        UIView.animate(withDuration: 3, delay: 0, options: [.transitionCurlUp]) {
            self.loginPassword.frame = CGRect(x: 238, y: 89.5, width: 235, height: 36)
        } completion: { _ in
            self.loginPassword.didMoveToWindow()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginTextField.text = UserManager.username
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func loginToPush(_ sender: UIButton) {
                    
        if loginTextField.text?.isEmpty == true , passwordTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Login and password error",
                                          message: "Enter Login and password",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok",
                                          style: .cancel,
                                          handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }else if passwordTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Password error",
                                          message: "Enter password",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok",
                                          style: .cancel,
                                          handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if loginTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Login error",
                                          message: "Enter Login",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok",
                                          style: .cancel,
                                          handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if let _ = Double(loginTextField.text!){
            let alert = UIAlertController(title: "Name error",
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

extension LoginView : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

