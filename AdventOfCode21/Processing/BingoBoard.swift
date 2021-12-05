//
//  BingoBoard.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

class BingoBoard {
    var cells = [[BoardCell]]()

    var score: Int {
        guard isWinning() == true else { return 0 }
        return cells.reduce(0, {count, row in
            return count + row.reduce(0, {rowScore, cell in
                return rowScore + (cell.marked ? 0 : cell.value)
            })
        })
    }

    init(from textVersion: [String]) {
        for line in textVersion {
            var cellRow = [BoardCell]()
            let cellTexts = line.split(separator: " ")
            for cellText in cellTexts {
                let valueText = cellText.trimmingCharacters(in: .whitespaces)
                let value = Int(valueText) ?? 0
                cellRow.append(BoardCell(value: value))
            }
            cells.append(cellRow)
        }
    }

    func cellAt(row: Int, col: Int) throws -> BoardCell {
        guard (0...4).contains(row) else { throw AoCError.rangeError }
        guard (0...4).contains(col) else { throw AoCError.rangeError }
        return cells[row][col]
    }

    func call(value: Int) {
        for row in 0...4 {
            for column in 0...4 {
                do {
                    let cell = try cellAt(row: row, col: column)
                    if cell.value == value {
                        cell.marked = true
                    }
                } catch {
                    print("Out of range, looking for cell at row: \(row), column: \(column)")
                }
            }
        }
    }

    func isWinning() -> Bool {
        // do we have all cells in a row?
        for line in cells {
            if line.reduce(0, { count, cell in
                return cell.marked ? count + 1 : count
            }) == 5 {
                return true
            }
        }

        // do we have all cells in a column?
        for column in 0...4 {
            if cells.reduce(0, {count, row in
                return row[column].marked ? count + 1 : count
            }) == 5 {
                return true
            }
        }

        return false
    }
}

class BoardCell {
    let value: Int
    var marked: Bool

    init(value: Int) {
        self.value = value
        marked = false
    }
}

class BingoGame {
    var turn = 0
    var boards: [BingoBoard]
    var calls: [Int]
    var lastCall = -1
    var winningBoards = [(BingoBoard, Int)]()

    var haveAWinner: Bool {
        !winningBoards.isEmpty
    }

    init(calls: [Int], boards: [BingoBoard]) {
        self.calls = calls
        self.boards = boards
    }

    func singleTurn() {
        guard !calls.isEmpty else { return }
        lastCall = calls.removeFirst()
        for board in boards {
            board.call(value: lastCall)
            if board.isWinning() {
                winningBoards.append((board, lastCall))
            }
        }
        boards.removeAll(where: {$0.isWinning()})
    }
}

func readBingoGame(_ input: String) -> BingoGame? {
    var lines = readLines(input)
    guard lines.count > 5 else { return nil }
    let calls = lines.removeFirst().split(separator: ",")
    let numbers = calls.map({Int($0)!})
    var boards = [BingoBoard]()
    // now, group the remaining lines into boards
    for boardLines in lines.chunked(into: 5) where boardLines.count == 5 {
        boards.append(BingoBoard(from: boardLines))
    }
    return BingoGame(calls: numbers, boards: boards)
}
