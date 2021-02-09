import Foundation
@testable import CoronaProject
  
class MockAttemptsCountValidator:FieldValidator {
    
    var mockResualt = false
    
    func checkLoginAndPassword(_ login: String, _ password: String) -> Bool {
        return mockResualt
    }
}
