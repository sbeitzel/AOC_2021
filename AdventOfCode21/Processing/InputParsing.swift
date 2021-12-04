//
//  InputParsing.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

func readNumericStrings(_ input: String) -> [String] {
    return input.split(separator: "\n").filter({!$0.isEmpty}).map({ line in
        var digits = ""
        for character in line where character.isNumber {
            digits.append(character)
        }
        return digits
    })
}

func stringsToInts(_ input: [String]) -> [Int] {
    return input.map({Int($0)!})
}
