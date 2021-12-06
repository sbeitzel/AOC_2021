//
//  Day6Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/6/21.
//

@testable import AdventOfCode21
import XCTest

class Day6Tests: XCTestCase {
    var sampleInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Self.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_06", ofType: "txt") ?? "")
    }

    func testSimFish() throws {
        var lines = readLines(sampleInput)
        guard lines.count > 0 else { throw AoCError.parseError }
        let fish = lines.removeFirst().split(separator: ",")
        var fishStates = fish.map({Int($0)!})
        fishStates = simFish(fishStates)
        fishStates = simFish(fishStates)
        XCTAssertEqual(fishStates.count, 6)
        XCTAssertEqual(fishStates[0], 1)
    }

    func testLanternSim() throws {
        var lines = readLines(sampleInput)
        guard lines.count > 0 else { throw AoCError.parseError }
        let fish = lines.removeFirst().split(separator: ",")
        let fishStates = fish.map({Int($0)!})
        var population = Array.init(repeating: 0, count: 9)
        for state in fishStates {
            population[state] += 1
        }
        let theSim = LanternFishSim(maturityCounts: population)
        XCTAssertEqual(theSim.count, 5)
        for _ in 1...80 {
            theSim.step()
        }
        XCTAssertEqual(theSim.count, 5934)
        for _ in 81...256 {
            theSim.step()
        }
        XCTAssertEqual(theSim.count, 26984457539)
    }
}
