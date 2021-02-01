import Foundation

class AttemptsCountValidator:FieldValidator{
    
    private var fieldValidator: FieldValidator
    private var timer: Timer?
    private var numberOfAttempts = 0
    private var interval = 0
    static var boolCheck = false
    
    init(fieldValidator: FieldValidator) {
        self.fieldValidator = fieldValidator
    }
    private func passwordValidator(_ login: String , _ password: String) -> Bool {
        if password == "123456789"{
            AttemptsCountValidator.boolCheck = true
            return self.fieldValidator.checkLoginAndPassword(login, password)
        }else{
            AttemptsCountValidator.boolCheck = false
            guard numberOfAttemptsCheck() else {return false}
            print("number Of Attempts \(numberOfAttempts)")
            return self.fieldValidator.checkLoginAndPassword(login, password)
        }
    }
    
    private func numberOfAttemptsCheck() -> Bool{
        self.numberOfAttempts += 1
        if self.numberOfAttempts == 5{
            createTimer()
            return false
        }
        return true
    }
    
    private func createTimer(){
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] timer in
                self!.interval += 1
                print("step interval \(self!.interval)")
                if self!.interval == 5{
                timer.invalidate()
                print("stop timer")
                self!.interval = 0
                self!.numberOfAttempts = 0
            }
        })
    }
    
    func checkLoginAndPassword(_ login: String, _ password: String) -> Bool {
        if self.interval == 0{
            return passwordValidator(login, password)
        }else{
            return false
        }
    }
}
