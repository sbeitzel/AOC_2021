//
//  InputParsing.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

func readNumericStrings(_ input: String) -> [String] {
    return readLines(input).map({ line in
        var digits = ""
        for character in line where character.isNumber {
            digits.append(character)
        }
        return digits
    })
}

func stringsToInts(_ input: [String]) -> [Int] {
    var numbers = [Int]()
    for word in input {
        if let number = Int(word) {
            numbers.append(number)
        }
    }
    return numbers
}

func binaryStringsToInts(_ input: [String]) -> [Int] {
    return input.map({ string -> Int in
        var value: Int = 0
        for digit in string {
            value = value << 1
            if digit == "1" {
                value |= 1
            }
        }
        return value
    })
}

func intsToBinaryStrings(_ input: [Int], places: Int) -> [String] {
    var strings = [String]()
    for number in input {
        var binaryString = ""
        for exponent in (0..<places).reversed() {
            let mask = 1 << exponent
            if number & mask > 0 {
                binaryString.append("1")
            } else {
                binaryString.append("0")
            }
        }
        strings.append(binaryString)
    }
    return strings
}

func readLines(_ input: String) -> [String] {
    var lines = [String]()
    for line in input.split(separator: "\n").filter({!$0.isEmpty}) {
        lines.append("\(line)")
    }
    return lines
}
