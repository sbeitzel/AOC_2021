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

    var bitCounts: [Int] {
        var workingCounts = Array.init(repeating: 0, count: 64)
        for value in values {
            for exponent in (0...63) {
                let mask = 1 << exponent
                if value & mask > 0 {
                    workingCounts[exponent] += 1
                }
            }
        }
        return workingCounts
    }

    init() {
        values = []
        fieldWidth = 0
        threshold = 0
    }

    init(_ bitStrings: [String]) throws {
        guard let sample = bitStrings.first else { throw AoCError.parseError }
        self.fieldWidth = sample.count
        if bitStrings.count % 2 == 0 {
            self.threshold = bitStrings.count / 2
        } else {
            self.threshold = (bitStrings.count / 2) + 1
        }
        // convert the strings to numbers
        self.values = binaryStringsToInts(bitStrings)
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

    func computeGamma() -> Int {
        var gamma = 0
        for exponent in 0..<fieldWidth {
            gamma += mostCommonBit(exponent) << exponent
        }
        return gamma
    }

    func computeEpsilon() -> Int {
        var epsilon = 0
        for exponent in 0..<fieldWidth {
            epsilon += leastCommonBit(exponent) << exponent
        }
        return epsilon
    }

    func oxygen(startingPlace: Int) -> Int {
        guard values.count > 1 else { return 0 }
        var numbers = values

        let bit = mostCommonBit(startingPlace)
        let mask = 1 << startingPlace
        numbers = numbers.filter({ $0.matchesBitAtMask(mask: mask, bitValue: bit)})
        if numbers.count == 1 {
            return numbers[0]
        } else {
            guard startingPlace > 0 else {
                print("We got to the end!")
                return 0
            }
            let bitStrings = intsToBinaryStrings(numbers, places: fieldWidth)
            do {
                let subsetCounting = try BitCounting(bitStrings)
                return subsetCounting.oxygen(startingPlace: startingPlace-1)
            } catch {
                print("Error computing from subset!")
                return 0
            }
        }
    }

    func carbonDioxide(startingPlace: Int) -> Int {
        guard values.count > 1 else { return 0 }
        var numbers = values

        let bit = leastCommonBit(startingPlace)
        let mask = 1 << startingPlace
        numbers = numbers.filter({ $0.matchesBitAtMask(mask: mask, bitValue: bit)})
        if numbers.count == 1 {
            return numbers[0]
        } else {
            guard startingPlace > 0 else {
                print("We got to the end!")
                return 0
            }
            let bitStrings = intsToBinaryStrings(numbers, places: fieldWidth)
            do {
                let subsetCounting = try BitCounting(bitStrings)
                return subsetCounting.carbonDioxide(startingPlace: startingPlace-1)
            } catch {
                print("Error computing from subset!")
                return 0
            }
        }
    }
}

enum AoCError: Error { case parseError, rangeError }
