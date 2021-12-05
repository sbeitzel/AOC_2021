//
//  Day3Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/4/21.
//

import XCTest
@testable import AdventOfCode21

class Day3Tests: XCTestCase {
    var sampleInput: String = ""
    var garbageInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Day3Tests.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_03", ofType: "txt") ?? "")
        garbageInput = try String(contentsOfFile: bundle.path(forResource: "garbage_03", ofType: "txt") ?? "")
    }

    func testCountingBits() throws {
        let countingStruct = try BitCounting(readLines(sampleInput))
        XCTAssert(countingStruct.mostCommonBit(4) == 1)
        XCTAssert(countingStruct.mostCommonBit(3) == 0)
        XCTAssert(countingStruct.mostCommonBit(2) == 1)
        XCTAssert(countingStruct.mostCommonBit(1) == 1)
        XCTAssert(countingStruct.mostCommonBit(0) == 0)
    }

    func testIntsToBinaryStrings() {
        let eleven = 11
        let stringArray = intsToBinaryStrings([eleven], places: 5)
        XCTAssertEqual(stringArray[0], "01011")
    }

    func testSubsetBits() throws {
        let subsetStruct = try BitCounting(
            readLines(try String(contentsOfFile: Bundle(for: Day3Tests.self)
                                    .path(forResource: "sample_o2", ofType: "txt") ?? ""))
        )
        XCTAssertEqual(subsetStruct.mostCommonBit(3), 0)
    }

    func testOxygen() throws {
        let countingStruct = try BitCounting(readLines(sampleInput))
        XCTAssertEqual(countingStruct.oxygen(startingPlace: countingStruct.fieldWidth-1), 23)
    }

    func testCarbonDioxide() throws {
        let countingStruct = try BitCounting(readLines(sampleInput))
        XCTAssertEqual(countingStruct.carbonDioxide(startingPlace: countingStruct.fieldWidth - 1), 10)
    }

    func testComputeGamma() throws {
        let countingStruct = try BitCounting(readLines(sampleInput))
        XCTAssertEqual(countingStruct.computeGamma(), 22)
    }

    func testComputeEpsilon() throws {
        let countingStruct = try BitCounting(readLines(sampleInput))
        XCTAssertEqual(countingStruct.computeEpsilon(), 9)
    }

    func testConvertGarbage() throws {
        _ = try BitCounting(readLines(garbageInput))
    }
}
