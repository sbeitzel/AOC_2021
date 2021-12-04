//
//  BitCounting.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

struct BitCounting {
    let values: [Int]
    let fieldWidth: Int
    let threshold: Int
    let bitCounts: [Int]

    init(_ bitStrings: [String]) throws {
        guard let sample = bitStrings.first else { throw AoCError.parseError }
        self.fieldWidth = sample.count
        self.threshold = bitStrings.count / 2
        var workingCounts = Array.init(repeating: 0, count: self.fieldWidth)
        // convert the strings to numbers
        self.values = bitStrings.map({ string -> Int in
            var value: Int = 0
            for digit in string {
                value = value << 1
                if digit == "1" {
                    value |= 1
                }
            }
            return value
        })

        // now, find the most/least frequent bit in each place
        for value in values {
            for exponent in 0..<self.fieldWidth where value & (1 << exponent) > 0 {
                workingCounts[exponent] += 1
            }
        }
        self.bitCounts = workingCounts
    }

    func mostCommonBit(_ place: Int) -> Int {
        if bitCounts[place] >= threshold {
            return 1
        }
        return 0
    }

    func leastCommonBit(_ place: Int) -> Int {
        if bitCounts[place] < threshold {
            return 1
        }
        return 0
    }

    func doesMatch(value: Int, mask: Int) -> Bool {
        return value & mask != 0
    }
}

enum AoCError: Error { case parseError }
