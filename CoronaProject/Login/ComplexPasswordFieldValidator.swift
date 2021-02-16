import Foundation


class ComplexLogPassFieldValidator: FieldValidator {
    func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool{
        if ((login != "") && (validatePassword(password))){
            return true
        } else {
            return false
        }
        
    }
    private func validatePassword(_ passwordText: String) -> Bool {
            if passwordText.count >= 8 {
                return true
            } else {
                return false
            }
        }
}
