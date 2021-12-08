//
//  CrabSubs.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/7/21.
//

import Algorithms
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

    // swiftlint:disable:next large_tuple
    var bestPositionAndCost: (Int, Int, Int) {
        return optimisticLinearSearch(minPos: minPosition, maxPos: maxPosition, depth: 0)
    }

    // swiftlint:disable:next large_tuple
    func floodFind() -> (Int, Int, Int) {
        var bestCost = Int.max
        var bestPosition = -1
        var checksSinceBetter = 0
        var totalChecks = 0
        let initial = mostFrequentPosition

        let sortedPositions = (minPosition...maxPosition).sorted(by: { abs($0 - initial) < abs($1 - initial)})

        for position in sortedPositions {
            let cost = costForTarget(position)
            totalChecks += 1
            if cost < bestCost {
                bestPosition = position
                bestCost = cost
                checksSinceBetter = 0
            } else {
                checksSinceBetter += 1
            }
            if checksSinceBetter > 3 {
                break
            }
        }

        return (bestPosition, bestCost, totalChecks)
    }

    // swiftlint:disable:next large_tuple
    func optimisticLinearSearch(minPos: Int, maxPos: Int, depth: Int) -> (Int, Int, Int) {
        // We're going to assume that we've got a parabola with
        // one minimum point. So, we start our search with an array
        // of possible choices. We pick the midpoint and compute its value.
        guard maxPos > minPos else { return (maxPos, costForTarget(maxPos), depth) }
        if maxPos - minPos == 1 {
            // we have only to compare these two
            let maxCost = costForTarget(maxPos)
            let minCost = costForTarget(minPos)

            return (minCost < maxCost) ? (minPos, minCost, depth) : (maxPos, maxCost, depth)
        }

        let midpoint = Int(floor( ( Double(maxPos - minPos)/2.0) )) + minPos
        let midpointCost = costForTarget(midpoint)

        // now, we examine the point directly to the right of the midpoint
        let increasingXCost = costForTarget(midpoint+1)
        if increasingXCost > midpointCost {
            // now we know that everything to the right of midpoint is worse
            let subrangeOptimum = optimisticLinearSearch(minPos: minPos, maxPos: midpoint, depth: depth+1)
            if subrangeOptimum.1 < midpointCost {
                return subrangeOptimum
            } else {
                return (midpoint, midpointCost, depth+1)
            }
        } else {
            // we believe that the best answer is somewhere to the right
            let subrangeOptimum = optimisticLinearSearch(minPos: midpoint+1, maxPos: maxPos, depth: depth+1)
            if subrangeOptimum.1 < increasingXCost {
                return subrangeOptimum
            } else {
                return (midpoint+1, increasingXCost, depth+1)
            }
        }
    }

    // swiftlint:disable:next large_tuple
    func exhaustiveSearch() -> (Int, Int, Int) {
        var computations = 0
        if let best = (minPosition...maxPosition).min(by: {lhs, rhs in
            computations += 2
            return costForTarget(lhs) < costForTarget(rhs)
        }) {
            return (best, costForTarget(best), computations)
        }
        return (Int.min, Int.max, computations)
    }

    func costForTarget(_ dest: Int) -> Int {
        return startingPositions.reduce(0, {intermediate, tuple in
            let cost = recursiveCompute(value: abs(dest - tuple.key)) * tuple.value
            return intermediate + cost
        })
    }

    func recursiveCompute(value: Int) -> Int {
        if value == 0 {
            return 0
        }
        if let precomputed = costDictionary[value] {
            return precomputed
        }
        let computed = value + recursiveCompute(value: value - 1)
        costDictionary[value] = computed
        return computed
    }
}
