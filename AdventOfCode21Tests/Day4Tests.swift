//
//  Day4Tests.swift
//  AdventOfCode21Tests
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Algorithms
import XCTest
@testable import AdventOfCode21

class Day4Tests: XCTestCase {
    var sampleInput: String = ""

    override func setUpWithError() throws {
        let bundle = Bundle(for: Self.self)
        sampleInput = try String(contentsOfFile: bundle.path(forResource: "sample_04", ofType: "txt") ?? "")
    }

    func testParseBingoCalls() throws {
        let lines = readLines(sampleInput)
        let calls = lines[0].split(separator: ",")
        let numbers = calls.map({Int($0)!})
        XCTAssertEqual(calls.count, 27)
        XCTAssertEqual(numbers.count, 27)
        XCTAssertEqual(numbers[8], 0)
    }

    func testParseBingoBoards() throws {
        var lines = readLines(sampleInput)
        _ = lines.removeFirst()
        var boards = [BingoBoard]()
        // now, group the remaining lines into boards
        for boardLines in lines.chunked(into: 5) where boardLines.count == 5 {
            boards.append(BingoBoard(from: boardLines))
        }
        XCTAssertEqual(boards.count, 3)
        for board in boards {
            XCTAssertEqual(board.cells.count, 5)
        }
    }

    func testParseBingoGame() throws {
        if let game = readBingoGame(sampleInput) {
            XCTAssertEqual(game.calls.count, 27)
            XCTAssertEqual(game.calls[8], 0)
            XCTAssertEqual(game.boards.count, 3)
        } else {
            XCTFail("Failed to parse the sample data")
        }
    }

    func testCallBingoGame() throws {
        let game = readBingoGame(sampleInput)!
        for _ in 1...11 {
            game.singleTurn()
            XCTAssertEqual(game.haveAWinner, false)
        }
        game.singleTurn()
        XCTAssertEqual(game.lastCall, 24, "The twelfth call should be 24!")
        XCTAssert(game.haveAWinner, "We should have a winner!")
        XCTAssertEqual(game.winningBoards.count, 1)
        if let winningTuple = game.winningBoards.first {
            XCTAssertEqual(winningTuple.0.score * winningTuple.1, 4512)
        } else {
            XCTFail("Couldn't get the winning board!")
        }
    }

    func testFindLastWinningBoard() throws {
        if let game = readBingoGame(sampleInput) {
            while !game.boards.isEmpty {
                game.singleTurn()
            }
            let lastWinner = game.winningBoards.last!
            XCTAssertEqual(lastWinner.0.score * lastWinner.1, 1924)
        } else {
            XCTFail("Couldn't read the sample data")
        }
    }
}
