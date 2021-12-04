//
//  Day1Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/4/21.
//

@testable import AdventOfCode21
import XCTest

class Day1Tests: XCTestCase {
    var sampleInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Day1Tests.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_1", ofType: "txt") ?? "")
    }

    func testFindIncreasingPairs() {
        XCTAssert(countIncreasingPairs(stringsToInts(readNumericStrings(sampleInput))) == 7)
    }

    func testfindIncreasingTriplets() {
        XCTAssert(countIncreasingTriplets(stringsToInts(readNumericStrings(sampleInput))) == 5)
    }

    func testIntConversion() {
        let numbers = stringsToInts(readNumericStrings(sampleInput))
        XCTAssert(numbers.count == 10)
        XCTAssert(numbers[0] == 199)
        XCTAssert(numbers[9] == 263)
    }

    func testInputSplitting() {
        let strings = readNumericStrings(sampleInput)
        XCTAssert(strings.count == 10)
    }
}
