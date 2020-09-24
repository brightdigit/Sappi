import XCTest

import sappiTests

var tests = [XCTestCaseEntry]()
tests += sappiTests.__allTests()

XCTMain(tests)
