//
//  Day7Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/7/21.
//

@testable import AdventOfCode21
import XCTest

class Day7Tests: XCTestCase {
    var sampleInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Self.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_07", ofType: "txt") ?? "")
    }

    func testHugeDataSet() throws {
        let bundle = Bundle(for: Self.self)
        let hugeData = try String(contentsOfFile: bundle.path(forResource: "huge_07", ofType: "txt") ?? "")
        var lines = readLines(hugeData)
        guard lines.count > 0 else { throw AoCError.parseError }
        let subs = lines.removeFirst().split(separator: ",").map({Int($0)!})
        let computer = CrabSubMover(subPositions: subs)
        let bestTuple = computer.bestPositionAndCost
        print("Best position/cost is \(bestTuple.0), \(bestTuple.1)")
    }

    func testCrabSubs() throws {
        var lines = readLines(sampleInput)
        guard lines.count > 0 else { throw AoCError.parseError }
        let subs = lines.removeFirst().split(separator: ",").map({Int($0)!})
        let computer = CrabSubMover(subPositions: subs)
        XCTAssertEqual(computer.costForTarget(2), 206)
    }

    func testMaxHypothesis() throws {
        var lines = readLines(sampleInput)
        guard lines.count > 0 else { throw AoCError.parseError }
        let subs = lines.removeFirst().split(separator: ",").map({Int($0)!})
        let computer = CrabSubMover(subPositions: subs)
        for pos in computer.minPosition...computer.maxPosition {
            print("\(pos)\t\(computer.costForTarget(pos).ungroupedString())")
        }
    }

    func testCrabSubsSolver() throws {
        var lines = readLines(sampleInput)
        guard lines.count > 0 else { throw AoCError.parseError }
        let subs = lines.removeFirst().split(separator: ",").map({Int($0)!})
        let computer = CrabSubMover(subPositions: subs)
        let bestTuple = computer.bestPositionAndCost
        XCTAssertEqual(bestTuple.0, 5)
        XCTAssertEqual(bestTuple.1, 168)
    }
}
