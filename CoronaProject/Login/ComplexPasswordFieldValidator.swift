import Foundation


class ComplexLogPassFieldValidator: FieldValidator {
    func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool{
        if ((login != "") && (checkPasswordCount(password))){
            return true
        }else {
            return false
        }
        
    }
    
    private func checkPasswordCount(_ password: String) -> Bool{
        if password.count >= 9 {
            return true
        }else{
            return false
        }
    }
    
    func passwordValidator(_ password: String) -> Bool {
        return false
    }
}
