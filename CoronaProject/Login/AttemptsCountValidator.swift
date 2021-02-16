import Foundation

class AttemptsCountValidator:FieldValidator{
    
    private var fieldValidator: FieldValidator
    static var numberOfAttempts = 0
    private var interval = 0
    static var boolCheck = false
    
    init(fieldValidator: FieldValidator) {
        self.fieldValidator = fieldValidator
    }
    private func passwordValidator(_ login: String , _ password: String) -> Bool {
        if differentCaseExisting(password) == true{
            AttemptsCountValidator.boolCheck = true
            return self.fieldValidator.checkLoginAndPassword(login, password)
        } else {
            AttemptsCountValidator.boolCheck = false
            guard numberOfAttemptsCheck() else {return false}
            return self.fieldValidator.checkLoginAndPassword(login, password)
        }
    }
    
    private func numberOfAttemptsCheck() -> Bool{
        if AttemptsCountValidator.numberOfAttempts == 5{
            createTimer()
            return false
        }
        return true
    }
    
    private func createTimer(){
             _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] timer in
                self!.interval += 1
                print("step interval \(self!.interval)")
                if self!.interval == 5{
                timer.invalidate()
                print("stop timer")
                self!.interval = 0
                    AttemptsCountValidator.numberOfAttempts = 0
            }
        })
    }
    
    private func differentCaseExisting(_ password: String) -> Bool {
        var upperCase = false
        var lowerCase = false
        for char in password {
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

    
    func checkLoginAndPassword(_ login: String, _ password: String) -> Bool {
        if self.interval == 0{
            return passwordValidator(login, password)
        } else {
            return false
        }
    }
}
