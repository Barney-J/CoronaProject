import XCTest

@testable import CoronaProject1

class CoronaProject1Tests: XCTestCase {

    var validator: ComplexLogPassFieldValidator!
    var passwordValidator : AttemptsCountValidator!
    
    override func setUpWithError() throws {
        validator = ComplexLogPassFieldValidator()
        passwordValidator = AttemptsCountValidator(fieldValidator: ComplexLogPassFieldValidator())
    }

    override func tearDownWithError() throws {
        validator = nil
    }

    func testThatOnFilledFieldCheckPassed() throws {
        let resualt = validator.checkLoginAndPassword("Eugene", "123456789")
        XCTAssertTrue(resualt)
    }
    func testThatOnInsufficientPasswordCharacters() throws {
        let resualt = validator.checkLoginAndPassword("Eugene", "156781")
        XCTAssertFalse(resualt)
    }
    
    func testThatOnEmptyLoginField() throws {
        let resualt = validator.checkLoginAndPassword("", "123456781")
        XCTAssertFalse(resualt)
    }
    func testThatOnEmptyPasswordField() throws {
        let resualt = validator.checkLoginAndPassword("Eugene", "")
        XCTAssertFalse(resualt)
    }
    
    func testCheckAttemptsCountOnPasswordShort() throws {
        for _ in 1...3{
            let resualt = passwordValidator.passwordValidator("12345678")
            XCTAssertFalse(resualt)
        }
        let resualt = passwordValidator.passwordValidator("12345678")
        XCTAssertFalse(resualt)
    }
    func testCheckAttemptsCountOnPassword() throws {
            let resualt = passwordValidator.passwordValidator("123456789")
            XCTAssertTrue(resualt)
    }

}
