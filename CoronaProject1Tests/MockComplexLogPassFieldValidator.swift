import Foundation
@testable import CoronaProject1
  
class MockComplexLogPassFieldValidator:AttemptsCountValidator {
    
    var mockResualt = false
    
    func checkPassword(_ password: String) -> Bool {
        return mockResualt 
    }
    
}
