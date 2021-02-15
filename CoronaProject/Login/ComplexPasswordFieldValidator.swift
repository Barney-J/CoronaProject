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
            if passwordText.count >= 8 && differentCaseExisting(passwordText) {
                return true
            } else {
                return false
            }
        }
    
    private func differentCaseExisting(_ str: String) -> Bool {
        var upperCase = false
        var lowerCase = false
        for char in str {
            if char.isUppercase {
                 upperCase = true
             }
            if char.isLowercase {
                lowerCase = true
            }
         }
        if upperCase && lowerCase {
            return true
        } else {
            return false
        }
     }
}
