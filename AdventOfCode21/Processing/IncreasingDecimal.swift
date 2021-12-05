//
//  IncreasingDecimal.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Algorithms
import Foundation

func countIncreasingPairs(_ numbers: [Int]) -> Int {
    guard numbers.count > 1 else { return 0 }
    return numbers.adjacentPairs().reduce(0, { result, tuple in
        if tuple.0 < tuple.1 {
            return result + 1
        }
        return result
    })
}

func countIncreasingTriplets(_ numbers: [Int]) -> Int {
    return countIncreasingPairs(numbers
                                    .windows(ofCount: 3)
                                    .map({$0.reduce(0, +)}))
}
