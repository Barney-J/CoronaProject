import XCTest

@testable import CoronaProject1

class AttemptsCountValidatorTests: XCTestCase {
    
   var mock = MockAttemptsCountValidator()
    var validator: AttemptsCountValidator!
    
    
    override func setUpWithError() throws {
        validator = AttemptsCountValidator(fieldValidator: mock)
    }

    override func tearDownWithError() throws {
//        validator = nil
        mock.mockResualt = false
    }
    
    func testCheckAttemptsCountOnPassword() throws {
        for _ in 1...6{
            let resualt = validator.checkLoginAndPassword("Eugene", "12345678")
            XCTAssertFalse(resualt)
        }
        let resualt = validator.checkLoginAndPassword("Eugene", "123456789")
        mock.mockResualt = true
        XCTAssertFalse(resualt)
    }
    
    func testForTheCorrectLastAttempt () throws {
        for _ in 1...4{
            let resualt = validator.checkLoginAndPassword("Eugene", "12345678")
            XCTAssertFalse(resualt)
        }
        mock.mockResualt = true
        let resualt = validator.checkLoginAndPassword("Eugene", "123456789")
        XCTAssertTrue(resualt)
    }

}
