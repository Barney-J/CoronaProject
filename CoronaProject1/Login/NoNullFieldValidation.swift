import Foundation
import UIKit
 
class LoginFieldValidation: FieldValidator {
    
    public func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool{
        if ((login != "") && (password != "")){
            return true
        }else {
            return false
        }
    }
}
