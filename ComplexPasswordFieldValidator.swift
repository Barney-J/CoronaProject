import Foundation


class ComplexPasswordFieldValidator: FieldValidator {
    
    public func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool{
        if ((login != "") && (password != "")){
            return true
        }else {
            return false
        }
    }
    
    private func checkLoginAndPasswordCount(_ login: String ,_ password: String) -> Bool{
        if login.count <= 8 , password.count >= 9{
            return true
        }else{
            return false
        }
    }
}
