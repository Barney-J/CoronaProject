import Foundation

protocol FieldValidator  {
    func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool
    func passwordValidator(_ password: String) -> Bool
}

class AttemptsCountValidator: FieldValidator{
    var fieldValidator: FieldValidator
    var numberOfAttempts = 0
    var timer: Timer?
    
    init(fieldValidator: FieldValidator) {
        self.fieldValidator = fieldValidator
    }
    func passwordValidator(_ password: String) -> Bool {
        if password == "123456789"{
            return true
        }else{
            if numberOfAttempts != 0{
                self.numberOfAttempts += 1
                print("Number of Attempts \(numberOfAttempts)")
            }else{
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                })
                
            }
            return false
        }
    }
    func checkLoginAndPassword(_ login: String, _ password: String) -> Bool {
        return fieldValidator.checkLoginAndPassword(login, password).self
    }
}
