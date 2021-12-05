//
//  Day2Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/4/21.
//

@testable import AdventOfCode21
import XCTest

class Day2Tests: XCTestCase {
    var sampleInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Day2Tests.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_02", ofType: "txt") ?? "")
    }

    func testProcessCommands() {
        let finalPosition = processCommands(readLines(sampleInput))
        XCTAssert(finalPosition.0 == 15)
        XCTAssert(finalPosition.1 == 60)
    }

    func testEmptyCommands() {
        let finalPosition = processCommands(readLines(""))
        XCTAssert(finalPosition.0 == 0)
        XCTAssert(finalPosition.1 == 0)
    }
}
