import Foundation
import UIKit
 
class LoginFieldValidation {
    
    public func checkLoginAndPassword ( _loginText login: String , _passwordText password: String) -> Bool{
        if ((login != "") && (password != "")){
            return true
        }else {
            return false
        }
    }
    public func checkLoginCount( _loginText login: String , _passwordText password: String) -> Bool{
        if login.count <= 8 , password.count >= 9{
            return true
        }else{
            return false
        }
    }
}
