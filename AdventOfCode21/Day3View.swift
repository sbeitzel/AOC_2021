//
//  Day3View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/3/21.
//

import SwiftUI

struct Day3View: View {
    let fullInput: String

    @State private var gammaRate = 0
    @State private var epsilonRate = 0
    @State private var consumption = 0
    @State private var oxygen = 0
    @State private var carbondioxide = 0
    @State private var lifeRating = 0

    @State private var computed = false

    init() {
        do {
            let contents = try String(contentsOfFile: Bundle.main.path(forResource: "day3input", ofType: "txt") ?? "")
            self.fullInput = contents
        } catch {
            print("There was an error requesting the input!")
            self.fullInput = ""
        }
    }

    var body: some View {
        VStack {
            Button {
                compute()
            }
        label: {
            Text("Calculate")
            }
            .disabled(computed)
            Text("Gamma: \(gammaRate), Epsilon: \(epsilonRate), Consumption: \(consumption)").textSelection(.enabled)
            Text("Oxygen generation: \(oxygen)").textSelection(.enabled)
            Text("CO2 scrub rate: \(carbondioxide)").textSelection(.enabled)
            Text("Life support rating: \(lifeRating)").textSelection(.enabled)
        }
        .frame(minWidth: 300, idealWidth: 400, minHeight: 200, idealHeight: 450)
    }

    func compute() {
        let bitStrings = fullInput.split(separator: "\n")
        let sample = bitStrings.first!
        let numDigits = sample.count
        let threshold: Int = bitStrings.count / 2
        var bitCounts: [Int] = Array.init(repeating: 0, count: numDigits)

        // convert the strings to numbers
        let values: [Int] = bitStrings.map({ string -> Int in
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
            for exponent in 0..<numDigits where value & (1 << exponent) > 0 {
                bitCounts[exponent] += 1
            }
        }

        // compute the gamma and epsilon rates
        for exponent in 0..<numDigits {
            if mostCommonBit(place: exponent, bitCounts: bitCounts, threshold: threshold) == 1 {
                gammaRate += (1 << exponent)
            } else {
                epsilonRate += (1 << exponent)
            }
        }
        consumption = gammaRate * epsilonRate

        // filter to find the one true oxygen number
        oxygen = filterForMostCommon(values: values, bitCounts: bitCounts, place: numDigits - 1, threshold: threshold)
        carbondioxide = filterForLeastCommon(values: values,
                                             bitCounts: bitCounts,
                                             place: numDigits - 1,
                                             threshold: threshold)
        lifeRating = oxygen * carbondioxide
    }

    func mostCommonBit(place: Int, bitCounts: [Int], threshold: Int) -> Int {
        if bitCounts[place] >= threshold {
            return 1
        }
        return 0
    }

    func leastCommonBit(place: Int, bitCounts: [Int], threshold: Int) -> Int {
        if bitCounts[place] < threshold {
            return 1
        }
        return 0
    }

    func doesMatch(value: Int, mask: Int) -> Bool {
        return value & mask != 0
    }

    func filterForMostCommon(values: [Int], bitCounts: [Int], place: Int, threshold: Int) -> Int {
        // when we only have one value left, we return
        if values.count == 1 {
            return values[0]
        }
        guard place >= 0 else {
            print("ERROR: Going off the end!")
            return Int.min
        }

        let isOne = mostCommonBit(place: place, bitCounts: bitCounts, threshold: threshold) == 1
        let mask = 1 << place
        let filtered: [Int] = values.filter({value in
            if isOne {
                return doesMatch(value: value, mask: mask)
            } else {
                return !doesMatch(value: value, mask: mask)
            }
        })
        return filterForMostCommon(values: filtered, bitCounts: bitCounts, place: place - 1, threshold: threshold)
    }

    func filterForLeastCommon(values: [Int], bitCounts: [Int], place: Int, threshold: Int) -> Int {
        // when we only have one value left, we return
        if values.count == 1 {
            return values[0]
        }
        guard place >= 0 else {
            print("ERROR: Going off the end!")
            return Int.min
        }

        let isOne = leastCommonBit(place: place, bitCounts: bitCounts, threshold: threshold) == 1
        let mask = 1 << place
        let filtered: [Int] = values.filter({value in
            if isOne {
                return doesMatch(value: value, mask: mask)
            } else {
                return !doesMatch(value: value, mask: mask)
            }
        })
        return filterForLeastCommon(values: filtered, bitCounts: bitCounts, place: place - 1, threshold: threshold)
    }
}

struct Day3View_Previews: PreviewProvider {
    static var previews: some View {
        Day3View()
    }
}
