import XCTest

class BaseTestCase: XCTestCase {
    func given(_ task: () -> Void) {
        task()
    }
    func when(_ task: () -> Void) {
        task()
    }
    func then(_ task: () -> Void) {
        task()
    }
}
