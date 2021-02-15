import XCTest

@testable import CoronaProject

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
            let resualt = validator.checkLoginAndPassword("Eugene", "testtest")
            XCTAssertFalse(resualt)
        }
        let resualt = validator.checkLoginAndPassword("Eugene", "testTest")
        mock.mockResualt = true
        XCTAssertFalse(resualt)
    }
    
    func testForTheCorrectLastAttempt () throws {
        for _ in 1...4{
            let resualt = validator.checkLoginAndPassword("Eugene", "testTes")
            XCTAssertFalse(resualt)
        }
        mock.mockResualt = true
        let resualt = validator.checkLoginAndPassword("Eugene", "TestTest")
        XCTAssertTrue(resualt)
    }

}
