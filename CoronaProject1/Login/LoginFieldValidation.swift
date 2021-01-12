import Foundation
import UIKit
 
class LoginFieldValidation {
    
    func checkLoginAndPassword ( _loginText login: String , _passwordText password: String) -> Bool{
        if ((login != "") && (password != "")){
            return true
        }else {
            return false
        }
    }
}
