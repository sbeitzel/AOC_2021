//
//  CrabSubs.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/7/21.
//

import Foundation

class CrabSubMover {
    let startingPositions: [Int: Int]
    var costDictionary = [Int: Int]()
    let totalSubs: Int

    init(subPositions: [Int]) {
        self.totalSubs = subPositions.count
        var subDictionary = [Int: Int]()
        for crab in subPositions {
            subDictionary[crab] = 1 + (subDictionary[crab] ?? 0)
        }
        startingPositions = subDictionary
    }

    var positions: [Int] {
        startingPositions.keys.sorted(by: <)
    }

    var maxPosition: Int {
        positions.last ?? 0
    }

    var minPosition: Int {
        positions.first ?? 0
    }

    var mostFrequentPosition: Int {
        if let (value, _) = startingPositions.max(by: {$0.1 < $1.1}) {
            return value
        }
        return -1
    }

    var bestPositionAndCost: (Int, Int) {
        var bestCost = Int.max
        var bestPosition = -1
        var checksSinceBetter = 0
        var totalChecks = 0
        let initial = mostFrequentPosition

        print("Starting search at position \(initial)")

        let sortedPositions = (minPosition...maxPosition).sorted(by: { abs($0 - initial) < abs($1 - initial)})

        for position in sortedPositions {
            print("Examining \(position)")
            let cost = costForTarget(position)
            totalChecks += 1
            if cost < bestCost {
                bestPosition = position
                bestCost = cost
                checksSinceBetter = 0
                print("It's a better target!")
            } else {
                checksSinceBetter += 1
                print("It's not better")
            }
            if checksSinceBetter > 3 {
                print("We are definitely getting worse. We've found a local minimum, so we're bailing.")
                break
            }
        }
        print("Total checks to find best: \(totalChecks)")

        return (bestPosition, bestCost)
    }

    func costForTarget(_ dest: Int) -> Int {
        return startingPositions.reduce(0, {intermediate, tuple in
            let cost = getCost(value: abs(dest - tuple.key)) * tuple.value
            return intermediate + cost
        })
    }

    func sumUpTo(value: Int) -> Int {
        (0...value).reduce(0, +)
    }

    func getCost(value: Int) -> Int {
        if let cost = costDictionary[value] {
            return cost
        }
        costDictionary[value] = sumUpTo(value: value)
        return costDictionary[value]!
    }
}
