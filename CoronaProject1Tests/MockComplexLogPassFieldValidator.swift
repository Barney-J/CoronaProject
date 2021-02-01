import Foundation
@testable import CoronaProject1
  
class MockAttemptsCountValidator:FieldValidator {
    
    var mockResualt = false
    
    func checkLoginAndPassword(_ login: String, _ password: String) -> Bool {
        return mockResualt
    }
}
