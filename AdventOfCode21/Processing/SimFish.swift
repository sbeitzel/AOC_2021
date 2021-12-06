//
//  SimFish.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/6/21.
//

import Foundation

func simFish(_ fishStates: [Int]) -> [Int] {
    var updatedStates = [Int]()
    var newFish = [Int]()
    for fish in fishStates {
        if fish < 1 {
            newFish.append(8)
            updatedStates.append(6)
        } else {
            updatedStates.append(fish-1)
        }
    }
    updatedStates.append(contentsOf: newFish)
    return updatedStates
}

class LanternFishSim {
    var population: [Int]

    var count: Int {
        population.reduce(0, +)
    }

    init(maturityCounts: [Int]) {
        population = Array.init(repeating: 0, count: 9)
        for bucket in 0...8 where bucket < maturityCounts.count {
            population[bucket] = maturityCounts[bucket]
        }
    }

    func step() {
        var newBuckets = Array.init(repeating: 0, count: 9)
        newBuckets[8] = population[0]
        newBuckets[7] = population[8]
        newBuckets[6] = population[7] + population[0]
        for bucket in (0...5).reversed() {
            newBuckets[bucket] = population[bucket+1]
        }
        population = newBuckets
    }
}
