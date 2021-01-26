import Foundation

class AttemptsCountValidator:FieldValidator{
    
    private var fieldValidator: FieldValidator
    private var timer: Timer?
    private var numberOfAttempts = 0
    static var interval = 0
    
    init(fieldValidator: FieldValidator) {
        self.fieldValidator = fieldValidator
    }
    func passwordValidator(_ password: String) -> Bool {
        if password == "123456789"{
            return true
        }else {
            self.numberOfAttempts += 1
            print("Number of Attempts \(self.numberOfAttempts)")
            numberOfAttemptsCheck()
            return false
        }
    }
    
    private func numberOfAttemptsCheck() {
        if self.numberOfAttempts == 5{
            createTimer()
        }
    }
    
    private func createTimer(){
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] timer in
                AttemptsCountValidator.interval += 1
                print("step interval \(AttemptsCountValidator.interval)")
                if AttemptsCountValidator.interval == 5{
                timer.invalidate()
                print("stop timer")
                AttemptsCountValidator.interval = 0
                self!.numberOfAttempts = 0
            }
        })
    }
    
    func checkLoginAndPassword(_ login: String, _ password: String) -> Bool {
        return fieldValidator.checkLoginAndPassword(login, password).self
    }
}
