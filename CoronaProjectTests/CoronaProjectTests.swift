import XCTest

@testable import CoronaProject

class ComplexLogPassFieldValidatorTests: XCTestCase {

    var validator: ComplexLogPassFieldValidator!
    
    
    override func setUpWithError() throws {
        validator = ComplexLogPassFieldValidator()
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
    
    func testThatOnEmptyAllField() throws {
        let resualt = validator.checkLoginAndPassword("", "")
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
}
