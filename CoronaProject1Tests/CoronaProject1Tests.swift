import XCTest

@testable import CoronaProject1

class CoronaProject1Tests: XCTestCase {

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
    func testThatOnEmptyFieldCheckPassed() throws {
        let resualt = validator.checkLoginAndPassword("Eugene", "156781")
        XCTAssertFalse(resualt)
    }
    
    func testThatOnEmptyLogFieldCheckPassed() throws {
        let resualt = validator.checkLoginAndPassword("", "123456781")
        XCTAssertFalse(resualt)
    }
    func testThatOnEmptyPassFieldCheckPassed() throws {
        let resualt = validator.checkLoginAndPassword("Eugene", "")
        XCTAssertFalse(resualt)
    }
    
    func testCheckAttemptsCountOnPassword() throws {
        for _ in 1...2{
            let resualt = validator.checkLoginAndPassword("Eugene", "12345678")
            XCTAssertFalse(resualt)

        }
        let resualt = validator.checkLoginAndPassword("Eugene", "123456789")
        XCTAssertTrue(resualt)
    }
}
