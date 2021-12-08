//
//  Day5Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/6/21.
//

import XCTest

class Day5Tests: XCTestCase {
    var sampleInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Self.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_05", ofType: "txt") ?? "")
    }

    /*
     To avoid the most dangerous areas, you need to determine the number of points where at least two
     lines overlap. In the above example, this is anywhere in the diagram with a 2 or larger - a total
     of 5 points.

     Consider only horizontal and vertical lines. At how many points do at least two lines overlap?
     */

    func testHorizontalAndVertical() throws {
        throw XCTSkip()
    }
}
